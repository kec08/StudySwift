//
//  2025_08_14_ContainerValueKeyView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/14/25.
//

import SwiftUI

struct ChildSizeKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
      value = nextValue()
  }
}

struct ContainerValueKeyView: View {
  @State private var childSize: CGSize = .zero

  var body: some View {
    VStack {
      Text("Child size: \(childSize.width) x \(childSize.height)")
      
      ChildView()
        .background(
          GeometryReader { geometry in
            Color.clear
              .preference(key: SizePreferenceKey.self, value: geometry.size)
          }
       )
    }
    .onPreferenceChange(SizePreferenceKey.self) { newSize in
      self.childSize = newSize
    }
  }
}

#Preview {
    ContainerValueKeyView()
}
