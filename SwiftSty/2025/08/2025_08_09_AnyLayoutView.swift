//
//  2025_08_09_AnyLayoutView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/9/25.
//

import SwiftUI

struct RandomXVStackLayout: Layout {
  var spacing: CGFloat
  
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout [CGFloat]) -> CGSize {
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    let maxWidth = sizes.map { $0.width }.max() ?? 0
    let totalHeight = sizes.map { $0.height }.reduce(0) { $0 + $1 } + spacing * CGFloat(subviews.count - 1)
    return CGSize(width: proposal.width ?? maxWidth, height: totalHeight)
  }
  
  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout [CGFloat]) {
    var y = bounds.minY
    
    for (index, subview) in subviews.enumerated() {
      let size = subview.sizeThatFits(.unspecified)
      let randomX = bounds.minX + (bounds.width - size.width) * cache[index]
      let point = CGPoint(x: randomX, y: y)
      subview.place(at: point, anchor: .topLeading, proposal: ProposedViewSize(size))
      y += size.height + spacing
    }
  }
  
  func makeCache(subviews: Subviews) -> [CGFloat] {
    subviews.map { _ in CGFloat.random(in: 0...1) }
  }
}

struct AnyLayoutView: View {
  @State var isTapped: Bool = false
  var layout: AnyLayout {
    self.isTapped
    ? AnyLayout(RandomXVStackLayout(spacing: 30))
    : AnyLayout(HStackLayout(spacing: 30))
  }
  
  var body: some View {
    VStack(spacing: 50) {
      Spacer()
      
      layout {
        Rectangle()
          .fill(.green)
          .frame(width: 70, height: 70)
        
        Rectangle()
          .fill(.yellow)
          .frame(width: 70, height: 70)
        
        Rectangle()
          .fill(.red)
          .frame(width: 70, height: 70)
      }
      
      Button(
        action: {
          withAnimation {
            self.isTapped.toggle()
          }
        },
        label: {
          Text("Change")
        }
      )
      
      Spacer()
    }
  }
}

#Preview {
    AnyLayoutView()
}
