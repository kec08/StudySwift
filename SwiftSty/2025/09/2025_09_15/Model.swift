//
//  Model.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/15/25.
//

import Foundation

// GET /todos API용 모델
struct Todo: Identifiable, Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    
//    private enum CodingKeys: String, CodingKey {
//        case userId
//        case id
//        case title
//        case completed
//    }
}

// POST /posts API용 모델
struct TestPost: Codable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

// Customer 관련 모델 (참고용)
struct CustomerResponse: Codable {
    var customer: Customer
}

struct Customer: Codable, Identifiable {
    var id: String
    var name: String
    var phone: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
    var state: String
}
