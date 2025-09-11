//
//  Drama.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/11/25.
//

import Foundation

import Foundation

struct DramaCollection : Decodable {
    var bigBanner: String
    var dramas: [Drama]
    
    enum CodingKeys: String, CodingKey {
        case bigBanner = "BIG_BANNER"
        case dramas = "DRAMAS"
    }
}

struct Drama : Decodable {
    var categoryTitle: String
    var posters: [String]
    
    enum CodingKeys: String, CodingKey {
        case categoryTitle = "CATEGORY_TITLE"
        case posters = "POSTERS"
    }
}

