//
//  Car.swift
//  ListNavDemo
//
//  Created by 김은찬 on 9/8/25.
//

import SwiftUI

struct Car : Codable, Identifiable {
    var id: String
    var name: String
    
    var description: String
    var isHybrid: Bool
    
    var imageName: String
}
