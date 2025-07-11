//
//  dasfd.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import Charts
import SwiftUI

// 데이터 모델 정의
struct RectangleChartData: Identifiable {
    let name: String
    let count: Int
    
    var id: String { name }
}

// 샘플 데이터
let rectangleData: [RectangleChartData] = [
    .init(name: "Green", count: 250),
    .init(name: "James", count: 100),
    .init(name: "Tony", count: 70)
]

// RectangleMark 차트 뷰
struct RectangleMarkView: View {
    var body: some View {
        Chart {
            ForEach(rectangleData) { posting in
                RectangleMark(
                    x: .value("Name", posting.name),
                    y: .value("Posting", posting.count)
                )
                .foregroundStyle(by: .value("Name", posting.name))
            }
        }
        .frame(height: 200)
        .padding()
    }
}

// 미리보기
#Preview {
    RectangleMarkView()
}
