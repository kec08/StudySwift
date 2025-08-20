//
//  2025_08_21_ScrollOffsetChatView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/21/25.
//

import Combine
import SwiftUI

struct KeyboardAdaptive: ViewModifier {
  @State private var keyboardHeight: CGFloat = 0
  
  private let keyboardWillShow = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillShowNotification)
    .compactMap { notification in
      notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }
    .map { rect in
      rect.height
    }
  
  private let keyboardWillHide = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillHideNotification)
    .map { _ in CGFloat(0) }
  
  func body(content: Content) -> some View {
    content
      .padding(.bottom, keyboardHeight)
      .onReceive(
        Publishers.Merge(keyboardWillShow, keyboardWillHide)
      ) { height in
        withAnimation(.easeInOut) {
          self.keyboardHeight = height
        }
      }
  }
}

extension View {
  func keyboardAdaptive() -> some View {
    ModifiedContent(content: self, modifier: KeyboardAdaptive())
  }
}

struct ScrollOffsetChatView: View {
  @State var text: String = ""
  
  var body: some View {
    VStack {
      Text("상단 영역")
      
      Spacer()
      
      Rectangle()
        .fill(.green)
        .frame(height: 700)
      
      TextField(
        "내용을 입력하세요.",
        text: $text
      )
      
      Text("하단 영역")
    }
    .keyboardAdaptive()
  }
}

#Preview {
    ScrollOffsetChatView()
}
