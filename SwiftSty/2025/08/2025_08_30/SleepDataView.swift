//
//  SleepDataView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/30/25.
//

import SwiftUI
import HealthKit

// MARK: - 데이터 모델
struct DailySleep: Identifiable {
    let id = UUID()
    let date: Date
    let deepSleep: TimeInterval
    let remSleep: TimeInterval
    let coreSleep: TimeInterval
    let totalSleep: TimeInterval
    let avgHeartRate: Double?
    let avgRespRate: Double?
}

// MARK: - 뷰모델
class WeeklySleepViewModel: ObservableObject {
    private let healthStore = HKHealthStore()
    @Published var weeklySleep: [DailySleep] = []
    
    init() {
        requestAuthorization()
    }
    
    private func requestAuthorization() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
              let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate),
              let respType = HKObjectType.quantityType(forIdentifier: .respiratoryRate)
        else { return }
        
        healthStore.requestAuthorization(toShare: [], read: [sleepType, heartRateType, respType]) { success, error in
            if success {
                self.fetchWeeklyData()
            } else {
                print("권한 요청 실패: \(String(describing: error))")
            }
        }
    }
    
    private func fetchWeeklyData() {
        let calendar = Calendar.current
        let now = Date()
        guard let startDate = calendar.date(byAdding: .day, value: -6, to: now) else { return }
        
        fetchSleepData(startDate: startDate, endDate: now) { sleepDict in
            self.fetchVitals(startDate: startDate, endDate: now) { vitalsDict in
                var daily: [DailySleep] = []
                
                for day in sleepDict.keys {
                    let sleep = sleepDict[day] ?? (0,0,0,0)
                    let vitals = vitalsDict[day]
                    
                    daily.append(DailySleep(date: day,
                                            deepSleep: sleep.0,
                                            remSleep: sleep.1,
                                            coreSleep: sleep.2,
                                            totalSleep: sleep.3,
                                            avgHeartRate: vitals?.0,
                                            avgRespRate: vitals?.1))
                }
                
                daily.sort { $0.date < $1.date }
                DispatchQueue.main.async {
                    self.weeklySleep = daily
                }
            }
        }
    }
    
    // 수면 데이터
    private func fetchSleepData(startDate: Date, endDate: Date,
                                completion: @escaping ([Date:(TimeInterval,TimeInterval,TimeInterval,TimeInterval)]) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let query = HKSampleQuery(sampleType: sleepType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil) { _, results, _ in
            guard let samples = results as? [HKCategorySample] else { return }
            
            var dict: [Date:(TimeInterval,TimeInterval,TimeInterval,TimeInterval)] = [:]
            let cal = Calendar.current
            
            for s in samples {
                let duration = s.endDate.timeIntervalSince(s.startDate)
                let day = cal.startOfDay(for: s.startDate)
                
                var deep: TimeInterval = 0
                var rem: TimeInterval = 0
                var core: TimeInterval = 0
                
                switch HKCategoryValueSleepAnalysis(rawValue: s.value) {
                case .asleepCore:
                    core = duration
                case .asleepDeep:
                    deep = duration
                case .asleepREM:
                    rem = duration
                default:
                    break
                }
                
                let total = deep + rem + core
                let current = dict[day] ?? (0,0,0,0)
                dict[day] = (current.0 + deep, current.1 + rem, current.2 + core, current.3 + total)
            }
            
            completion(dict)
        }
        healthStore.execute(query)
    }

    
    // 심박수 & 호흡수 평균
    private func fetchVitals(startDate: Date, endDate: Date,
                             completion: @escaping ([Date:(Double,Double)]) -> Void) {
        guard let hrType = HKObjectType.quantityType(forIdentifier: .heartRate),
              let respType = HKObjectType.quantityType(forIdentifier: .respiratoryRate) else { return }
        
        let types: [(HKQuantityType,String)] = [(hrType,"HR"), (respType,"RR")]
        var result: [Date:(Double,Double)] = [:]
        let group = DispatchGroup()
        
        for (type, key) in types {
            group.enter()
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
            let query = HKSampleQuery(sampleType: type, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, _ in
                guard let samples = samples as? [HKQuantitySample] else { group.leave(); return }
                
                let cal = Calendar.current
                var dayValues: [Date:[Double]] = [:]
                
                for s in samples {
                    let value = s.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                    let day = cal.startOfDay(for: s.startDate)
                    dayValues[day, default: []].append(value)
                }
                
                for (day, arr) in dayValues {
                    let avg = arr.reduce(0,+) / Double(arr.count)
                    var current = result[day] ?? (0,0)
                    if key == "HR" { current.0 = avg }
                    if key == "RR" { current.1 = avg }
                    result[day] = current
                }
                
                group.leave()
            }
            healthStore.execute(query)
        }
        
        group.notify(queue: .main) {
            completion(result)
        }
    }
}

// MARK: - 뷰
struct SleepDataView: View {
    @StateObject private var viewModel = WeeklySleepViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.weeklySleep) { day in
                VStack(alignment: .leading, spacing: 6) {
                    Text(day.date, format: .dateTime.weekday(.wide))
                        .font(.headline)
                    
                    Text("총 수면: \(formatDuration(day.totalSleep))")
                        .font(.subheadline)
                    Text("깊은 수면: \(formatDuration(day.deepSleep)) | 렘 수면: \(formatDuration(day.remSleep)) | 코어 수면: \(formatDuration(day.coreSleep))")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    if let hr = day.avgHeartRate {
                        Text("평균 심박수: \(String(format: "%.1f", hr)) bpm")
                            .font(.footnote)
                    }
                    if let rr = day.avgRespRate {
                        Text("평균 호흡수: \(String(format: "%.1f", rr)) 회/분")
                            .font(.footnote)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("주간 수면 리포트")
        }
    }
    
    private func formatDuration(_ seconds: TimeInterval) -> String {
        let h = Int(seconds / 3600)
        let m = Int((seconds.truncatingRemainder(dividingBy: 3600)) / 60)
        return "\(h)시간 \(m)분"
    }
}


#Preview {
    SleepDataView()
}

