//
//  AreaMarkView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import SwiftUI
import Charts

struct AreaData: Identifiable {
    let name: String
    let count: Int
    var id: String { name }
}

let postingsss: [AreaData] = [
    .init(name: "Green", count: 250),
    .init(name: "James", count: 100),
    .init(name: "Tony", count: 70)
]

struct AreaMarkView: View {
    var body: some View {
        Chart {
            ForEach(postingsss) { posting in
                AreaMark(
                    x: .value("Name", posting.name),
                    y: .value("Posting", posting.count)
                )
            }
        }
    }
}

#Preview {
    AreaMarkView()
}
