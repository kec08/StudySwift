//
//  overlayView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/20/25.
//

import SwiftUI

//extension View {
//  @ViewBuilder public func overlayIf<T: View, U: View>(
//    _ condition: Bool,
//    _ firstContent: T,
//    _ secondContent: U = Spacer(),
//    alignment: Alignment = .center
//  ) -> some View {
//    if condition {
//      self.overlay(firstContent, alignment: alignment)
//    } else {
//      self.overlay(secondContent, alignment: alignment)
//    }
//  }
//}
//
//struct OverayView: View {
//  @State var displayOverlayContent: Bool = false
//  
//  var body: some View {
//    VStack {
//      Button(
//        action: { displayOverlayContent.toggle() },
//        label: { Text("버튼을 눌러 뷰를 끄고 킬 수 있습니다") }
//      )
//      Spacer()
//    }
//    .padding()
//    .overlayIf(
//      displayOverlayContent,
//      Color.green.frame(width: 300, height: 300)
//    )
//  }
//}
//
//#Preview {
//    OverayView()
//}

extension View {
  @ViewBuilder public func overlayIf<T: View>(
    _ condition: Bool,
    _ content: T,
    alignment: Alignment = .center
  ) -> some View {
    if condition {
      self.overlay(content, alignment: alignment)
    } else {
      self
    }
  }
}

struct OverayView: View {
  @State var displayOverlayContent = false

  var body: some View {
    VStack {
      Button("버튼을 눌러 뷰를 끄고 킬 수 있습니다") {
        displayOverlayContent.toggle()
      }

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
