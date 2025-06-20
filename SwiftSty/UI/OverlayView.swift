//
//  overlayView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/20/25.
//

import SwiftUI

extension View {
  @ViewBuilder public func overlayIf<T: View, U: View>(
    _ condition: Bool,
    _ firstContent: T,
    _ secondContent: U = Spacer(),
    alignment: Alignment = .center
  ) -> some View {
    if condition {
      self.overlay(firstContent, alignment: alignment)
    } else {
      self.overlay(secondContent, alignment: alignment)
    }
  }
}

struct OverayView: View {
  @State var displayOverlayContent: Bool = false
  
  var body: some View {
    VStack {
      Button(
        action: { displayOverlayContent.toggle() },
        label: { Text("Show and Hide Overlay Content") }
      )
      Spacer()
    }
    .padding()
    .overlayIf(
      displayOverlayContent,
      Color.green.frame(width: 300, height: 300)
    )
  }
}

#Preview {
    OverayView()
}
