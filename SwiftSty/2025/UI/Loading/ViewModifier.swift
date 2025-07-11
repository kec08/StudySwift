//
//  ViewModifier.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/22/25.
//

import SwiftUI

public extension View {
  func loading(
    _ isLoading: Bool
  ) -> Self {
    if isLoading {
      LoadingWindow.shared.show()
    } else {
      LoadingWindow.shared.hide()
    }
    return self
  }
}
