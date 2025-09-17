//
//  URL+Extensions.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/18/25.
//

import Foundation
import CoreLocation
let appid = ""
let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(appid)&units=metric"
extension URL {
    //도시 이름을 통해 날씨 정보를 가져오는  GET Rest API
   static func urlWith(city: String) -> URL? {
        return URL(string: "\(weatherURL)&q=\(city)")
    }
    //위치 값을 통해 날씨 정보를 가져오는  GET Rest API
    static func urlWith(coordinate : CLLocationCoordinate2D) -> URL? {
        let urlString = "\(weatherURL)&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        print(urlString)
        return URL(string: urlString)
    }
    
}
