//
//  WeatherViewModel.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/18/25.
//

import Foundation

func fetchWeatherDataWithCurrentLocation() {
       //locationService의 requestLocation 호출
       locationService.requestLocation { coordinate in
           //좌표 값을 수신한 경우 fetchWeatherData를 통해서 api 호출
           self.fetchWeatherData(coordinate: coordinate)
       }
   }
   
   private func fetchWeatherData(coordinate: CLLocationCoordinate2D) {
       let url = URL.urlWith(coordinate: coordinate)
       guard let safeUrl = url else {
           return
       }
       load(resource: Resource<WeatherData>(url: safeUrl))
   }
   
   private func load(resource: Resource<WeatherData>) {
       isLoading = true
       URLRequest.load(resource: resource) { (result) in
           switch result {
           case .success(let weatherData) :
               self.model = weatherData
           case .failure(let error) :
               print(error)
           }
           self.isLoading = false
       }
   }
