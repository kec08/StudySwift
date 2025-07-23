//
//  2025_07_24_ChipsView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI

public struct ChipsType: Equatable {
  let title: String
  let priority: Int
  
  public init(
    title: String,
    priority: Int = 0
  ) {
    self.title = title
    self.priority = priority
  }
  
  public static func == (lhs: ChipsType, rhs: ChipsType) -> Bool {
    lhs.title == rhs.title
  }
}

public struct ChipView: View {
  private var title: String
  
  public init(title: String) {
    self.title = title
  }
  
  public var body: some View {
    Text(title)
      .font(.caption)
      .foregroundColor(.black)
      .padding(.horizontal, 10)
      .padding(.vertical, 3)
      .background(.white)
      .cornerRadius(16)
      .overlay(
        RoundedRectangle(cornerRadius: 16)
          .stroke(.green, lineWidth: 1)
      )
      .frame(height: 24)
  }
}

struct ChipsView: View {
  var items: [ChipsType] = [
    .init(title: "첫번째"),
    .init(title: "두번째", priority: 1),
    .init(title: "세번째", priority: 2),
    .init(title: "네번째", priority: 3),
    .init(title: "서른마흔다섯번째", priority: 4),
    .init(title: "여섯번째", priority: 5),
    .init(title: "일곱번째", priority: 6),
    .init(title: "여덟번째", priority: 7),
    .init(title: "아홉번째", priority: 8),
  ]
  
  var body: some View {
    let columns = [GridItem(.flexible(minimum: 100, maximum: .infinity)), GridItem(.flexible(minimum: 10, maximum: .infinity))]

    LazyVGrid(columns: columns, spacing: 5) {
      ForEach(items, id: \.title) { item in
        ChipView(title: item.title)
      }
    }
  }
}


#Preview {
    ChipsView()
}
