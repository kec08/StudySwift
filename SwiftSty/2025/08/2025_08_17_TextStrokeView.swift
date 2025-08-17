//
//  2025_08_17_TextStrokeView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/17/25.
//

import SwiftUI

struct TextStroke: ViewModifier {
  let color: Color
  let width: CGFloat
  
  func body(content: Content) -> some View {
    content
      .shadow(color: color, radius: 0, x: width, y: width)
      .shadow(color: color, radius: 0, x: -width, y: width)
      .shadow(color: color, radius: 0, x: width, y: -width)
      .shadow(color: color, radius: 0, x: -width, y: -width)
  }
}

extension View {
  func textStroke(color: Color = .black, width: CGFloat = 1) -> some View {
    modifier(TextStroke(color: color, width: width))
  }
}

struct TextStrokeView: View {
    var body: some View {
        Text("테두리 효과")
//          .font(.system(size: 30, weight: .bold))
//          .foregroundColor(.white)
//          .textStroke()
          .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 0, x: 3.0, y: 3.0)
                .shadow(color: .black, radius: 0, x: -3.0, y: 3.0)
                .shadow(color: .black, radius: 0, x: 3.0, y: -3.0)
                .shadow(color: .black, radius: 0, x: -3.0, y: -3.0)
    }
}

#Preview {
    TextStrokeView()
        
}
