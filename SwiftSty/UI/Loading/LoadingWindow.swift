//
//  LoadingWindow.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/22/25.
//

import SwiftUI

public struct LoadingView: View {
  public init() { }
  
  public var body: some View {
    VStack(spacing: 10) {
      ProgressView()
      Text("Loading")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(DesignSystem.Colors.white100.opacity(0.5))
  }
}
