//
//  2025_07_24_ChipsContainerMainView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI

public struct ChipsContainerView: View {
  @State private var totalHeight: CGFloat = .zero
  let verticalSpacing: CGFloat
  let horizontalSpacing: CGFloat
  let items: [ChipsType]
  
  var sortedItems: [ChipsType] {
    items.sorted { $0.priority < $1.priority }
  }
  
  public init(
    verticalSpacing: CGFloat = 4,
    horizontalSpacing: CGFloat = 4,
    items: [ChipsType]
  ) {
    self.verticalSpacing = verticalSpacing
    self.horizontalSpacing = horizontalSpacing
    self.items = items
  }
  
  public var body: some View {
    GeometryReader { geometry in
      self.generateContent(in: geometry)
    }
    .frame(height: totalHeight)
  }
  
  private func generateContent(in geometry: GeometryProxy) -> some View {
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    return ZStack(alignment: .topLeading) {
      ForEach(sortedItems, id: \.title) { item in
        ChipView(title: item.title)
          .alignmentGuide(.leading) { dimension in
            if width + dimension.width > geometry.size.width {
              width = 0
              height += dimension.height + verticalSpacing
            }
            let result = width
            width += dimension.width + horizontalSpacing
            return result
          }
          .alignmentGuide(.top) { _ in
            height
          }
      }
    }
    .background(
      GeometryReader { geo in
        Color.clear
          .onAppear {
            totalHeight = geo.size.height
          }
      }
    )
  }
}

struct ChipsContainerMainView: View {
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
    VStack {
      ChipsContainerView(items: items)
    }
    .padding()
  }
}

#Preview{
    ChipsContainerMainView()
}
