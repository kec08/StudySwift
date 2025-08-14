//
//  2025_08_15_MixColorView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/15/25.
//

import SwiftUI

struct MixColorView: View {
  @State private var dragAmount: CGFloat = 0
  
  var dragColor: Color {
    Color.green.mix(
      with: .yellow,
      by: min(max(dragAmount / 100, 0), 1)
    )
  }
  
  var body: some View {
    Rectangle()
      .frame(width: 300, height: 300)
      .foregroundStyle(dragColor)
      .animation(.spring, value: dragAmount)
      .gesture(
        DragGesture()
          .onChanged { gesture in
            dragAmount = gesture.translation.width
          }
          .onEnded { _ in
            dragAmount = 0
          }
      )
  }
}

#Preview {
    MixColorView()
}
