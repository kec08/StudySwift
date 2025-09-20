//
//  2025_09_17_MapShowView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/18/25.
//

import SwiftUI
import MapKit
import CoreLocation

// 위치 정보를 관리하는 클래스
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var manager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 서울 좌표
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // 위치 업데이트가 발생하면 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            }
        }
    }
}

struct MapShowView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isShowMapView: Bool = false
    
    var body: some View {
        VStack {
            if isShowMapView {
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
            }
            
            Button("지도에서 현재 위치 표시 보기") {
                isShowMapView = true
            }
            .padding()
        }
    }
}
