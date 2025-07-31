//
//  2025_08_01_RefactoringScrollOffsetView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/1/25.
//

import SwiftUI

// MARK: - OffsetObservableScrollView

struct RefactoringScrollOffsetView: View {
  let evenIndexColors: [Color] = [.green, .yellow, .red, .blue]
  let oddIndexColors: [Color] = [.red, .brown, .blue, .orange, .gray]
  @State var scrollOffset: CGPoint = .zero
  @State private var evenIndexViewSize: CGFloat = .zero
  @State private var oddIndexViewSize: CGFloat = .zero
  @State private var evenXOffset: CGFloat = .zero
  @State private var oddXOffset: CGFloat = .zero
  
  var body: some View {
    OffsetObservableScrollView(.horizontal, scrollOffset: $scrollOffset) { _ in
      VStack(alignment: .leading, spacing: 30) {
        SubView(colors: evenIndexColors)
          .onReadSize { size in
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               evenIndexViewSize = size.width
             }
           }
           .offset(x: evenXOffset)
        
        SubView(colors: oddIndexColors)
          .onReadSize { size in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              oddIndexViewSize = size.width
            }
          }
          .offset(x: oddXOffset)
      }
    }
    .padding()
    .onChange(of: scrollOffset) { scrollOffset in
      let scrollableWidthEven = evenIndexViewSize - UIScreen.main.bounds.width
      let scrollableWidthOdd = oddIndexViewSize - UIScreen.main.bounds.width
      if evenIndexViewSize < oddIndexViewSize {
        let scrollableRate = scrollableWidthEven / scrollableWidthOdd
        
        evenXOffset = scrollOffset.x * (1 - scrollableRate)
      } else if oddIndexViewSize > evenIndexViewSize {
        let scrollableRate = scrollableWidthOdd / scrollableWidthEven
        
        oddXOffset = scrollOffset.x * (1 - scrollableRate)
      }
    }
  }
}
// MARK: - Preview

#Preview {
    RefactoringScrollOffsetView()
}

