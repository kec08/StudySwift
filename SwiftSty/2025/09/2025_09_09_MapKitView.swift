//
//  MapKitView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/10/25.
//

//
//  GoMapView.swift
//  Eodigo
//
//  Created by 김은찬 on 9/8/25.
//

import SwiftUI
import MapKit

// 전화 걸기 함수
func makeCall(phone: String) {
    if let url = URL(string: "tel://\(phone)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Device can't make phone calls")
        }
    }
}

struct MapKitView: View {
    @State private var position: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(
                latitude: 37.5665,    // 서울 시청
                longitude: 126.9780
            ),
            distance: 980,            // 카메라 거리
            heading: 242,             // 방향
            pitch: 60                 // 기울기
        )
    )

    
    @State private var tapPosition: CLLocationCoordinate2D?   // 지도에서 탭한 위치
    @State private var phoneNumber: String?                   // 장소 전화번호
    @State private var searchText: String = ""                // 검색어
    @State private var searchResults: [MKMapItem] = []        // 검색 결과
    @State private var searchCompletions: [MKLocalSearchCompletion] = [] // 자동완성 결과
    
    @Namespace private var mapScope
    private var searchCompleter = MKLocalSearchCompleter()
    
    var body: some View {
        VStack {
            // 검색창
            TextField("장소 검색", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: searchText) { newValue in
                    searchCompleter.queryFragment = newValue
                    searchCompleter.resultTypes = .pointOfInterest
                    searchCompleter.delegate = SearchCompleterDelegate { completions in
                        self.searchCompletions = completions
                    }
                }
            
            // 자동완성 리스트
            if !searchCompletions.isEmpty {
                List(searchCompletions, id: \.title) { completion in
                    Button(action: {
                        search(for: completion.title + " " + completion.subtitle)
                        searchText = completion.title
                        searchCompletions = []
                    }) {
                        VStack(alignment: .leading) {
                            Text(completion.title).bold()
                            if !completion.subtitle.isEmpty {
                                Text(completion.subtitle).font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
                }
                .frame(height: 200)
            }
            
            // 지도 뷰
            MapReader { reader in
                Map(position: $position, scope: mapScope) {
                    
                    // 검색된 위치 표시
                    if let pos = tapPosition {
                        Annotation("선택한 위치", coordinate: pos) {
                            VStack {
                                Text("📍")
                                    .font(.largeTitle)
                                
                                if let phone = phoneNumber {
                                    Button(action: {
                                        let numericPhone = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                                        makeCall(phone: numericPhone)
                                    }) {
                                        Label("전화걸기", systemImage: "phone.fill")
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                        }
                    }
                }
                .mapStyle(.standard)
                .onTapGesture { screenCoord in
                    if let pinLocation = reader.convert(screenCoord, from: .local) {
                        tapPosition = pinLocation
                        phoneNumber = "010-1234-5678" // 테스트용
                    }
                }
            }
        }
    }
    
    // 실제 검색 실행
    private func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: position.region?.center ?? CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        Task {
            let search = MKLocalSearch(request: request)
            if let response = try? await search.start(),
               let firstItem = response.mapItems.first {
                tapPosition = firstItem.placemark.coordinate
                phoneNumber = firstItem.phoneNumber
                position = .region(MKCoordinateRegion(center: firstItem.placemark.coordinate,
                                                     span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            }
        }
    }
}

// 자동완성 Delegate를 래핑하는 클래스
class SearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    private let handler: ([MKLocalSearchCompletion]) -> Void
    
    init(handler: @escaping ([MKLocalSearchCompletion]) -> Void) {
        self.handler = handler
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        handler(completer.results)
    }
}

#Preview {
    MapKitView()
}
