//
//  LineMarkView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import Charts
import SwiftUI

struct lineMark: Identifiable {
    let name: String
    let count: Int
    
    var id: String { name }
}

let postingss: [lineMark] = [
    .init(name: "Green", count: 250),
    .init(name: "James", count: 100),
    .init(name: "Tony", count: 70)
]

struct LineMarkView: View {
    var body: some View {
        Chart {
            ForEach(postingss) { posting in
                LineMark(
                  x: .value("Name", posting.name),
                  y: .value("Posting", posting.count)
                )
            }
        }
    }
}

#Preview {
    LineMarkView()
}
