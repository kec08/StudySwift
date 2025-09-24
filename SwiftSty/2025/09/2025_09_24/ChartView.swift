//
//  Chart3DView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/22/25.
//

import SwiftUI
import Charts
import TabularData
import Spatial // Chart3DPose 애니메이션용

// MARK: - 모델
struct Iris: Identifiable {
    let id: Int
    let sepalLength: Double
    let sepalWidth: Double
    let petalLength: Double
    let petalWidth: Double
    let species: String
}

// MARK: - CSV 파싱
func parseIrisData() -> [Iris] {
    let fileUrl = Bundle.main.url(forResource: "Iris", withExtension: "csv")!
    let dataFrame = try! DataFrame(contentsOfCSVFile: fileUrl)
    
    return dataFrame.rows.compactMap { row in
        guard let id = row["Id"] as? Int,
              let sepalLengthCm = row["SepalLengthCm"] as? Double,
              let sepalWidthCm = row["SepalWidthCm"] as? Double,
              let petalLengthCm = row["PetalLengthCm"] as? Double,
              let petalWidthCm =     row["PetalWidthCm"] as? Double,
              let species = row["Species"] as? String else {
            return nil
        }
        return Iris(
            id: id,
            sepalLength: sepalLengthCm,
            sepalWidth: sepalWidthCm,
            petalLength: petalLengthCm,
            petalWidth: petalWidthCm,
            species: species
        )
    }
}

// MARK: - 3D 차트 뷰
struct Chart3DView: View {
    @State private var irisData: [Iris] = []
    @State private var pose = Chart3DPose(azimuth: .degrees(0), inclination: .degrees(20))
    @State private var azimuthAngle: Angle2D = .degrees(0)
    
    private let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    private let xLabel = "Petal Length (cm)"
    private let yLabel = "Petal Width (cm)"
    private let zLabel = "Sepal Length (cm)"
    
    var body: some View {
        Chart3D(irisData) { iris in
            PointMark(
                x: .value(xLabel, iris.petalLength),
                y: .value(yLabel, iris.petalWidth),
                z: .value(zLabel, iris.sepalLength)
            )
            .foregroundStyle(by: .value("Species", iris.species))
            .symbol(.sphere)
            .symbolSize(0.05)
        }
        .chartXAxisLabel(xLabel)
        .chartYAxisLabel(yLabel)
        .chartZAxisLabel(zLabel)
        .chart3DCameraProjection(.perspective)
        .chart3DPose($pose)
        .frame(height: 400)
        .padding()
        .onAppear {
            irisData = parseIrisData()
        }
        .onReceive(timer) { _ in
            azimuthAngle += .degrees(1)
            if azimuthAngle.degrees >= 360 {
                azimuthAngle = .degrees(0)
            }
            pose = Chart3DPose(azimuth: azimuthAngle, inclination: .degrees(20))
        }
    }
}

// MARK: - Preview
#Preview {
    Chart3DView()
}

