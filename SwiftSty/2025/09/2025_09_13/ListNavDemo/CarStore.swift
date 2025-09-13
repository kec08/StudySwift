//
//  CarStore.swift
//  ListNavDemo
//
//  Created by 김은찬 on 9/8/25.
//

import SwiftUI
import Combine

class CarStore: ObservableObject {
    
    @Published var cars: [Car]
    
    init (cars: [Car] = []) {
        self.cars = cars
    }
}
