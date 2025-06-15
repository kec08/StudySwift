//
//  Chart.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import Charts
import SwiftUI

// 밑에서 쭉 설명할 Marks에 대해서도 동일한 Postings 데이터 적용
struct Posting: Identifiable {
  let name: String
  let count: Int
  
  var id: String { name }
}

let postings: [Posting] = [
  .init(name: "Green", count: 250),
  
  .init(name: "James", count: 100),
  .init(name: "Tony", count: 70)
]

// 차트 그리기
struct BarMarkView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        BarMark(
            
            // 세로형
            x: .value("Name", posting.name),
            y: .value("Posting", posting.count)
          
          //가로형
//          x: .value("Posting", posting.count),
//          y: .value("Name", posting.name)
           
        )
      }
    }
  }
}

#Preview {
    BarMarkView()
}
