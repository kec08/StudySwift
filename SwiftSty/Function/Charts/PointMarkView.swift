//
//  PointMarkVIew.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import Charts
import SwiftUI

struct pointMark: Identifiable {
    let name: String
    let count: Int
    
    var id: String { name }
}

let posting: [pointMark] = [
    .init(name: "Green", count: 250),
    .init(name: "James", count: 100),
    .init(name: "Tony", count: 70)
]

struct PointMarkView: View {
    var body: some View {
        Chart {
            ForEach(postings) { posting in
                PointMark(
                    x: .value("Posting", posting.count),
                    y: .value("Name", posting.name)
                )
            }
        }
    }
}

#Preview {
    PointMarkView()
}
