//
//  RuleMarkChartView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import Charts
import SwiftUI

struct RuleChartData: Identifiable {
    let name: String
    let count: Int
    
    var id: String { name }
}

let sampleRuleData: [RuleChartData] = [
    .init(name: "Green", count: 250),
    .init(name: "James", count: 100),
    .init(name: "Tony", count: 70)
]

struct RuleMarktView: View {
    var body: some View {
        Chart {
            ForEach(sampleRuleData) { posting in
                RuleMark(
                    xStart: .value("Posting Start", posting.count),
                    xEnd: .value("Posting End", posting.count + 20),
                    y: .value("Name", posting.name)
                )
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundStyle(.blue)
            }
        }
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    RuleMarktView()
}
