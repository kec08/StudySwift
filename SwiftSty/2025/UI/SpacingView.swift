//
//  SpacingView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import SwiftUI

struct SpacingView: View {
  var body: some View {
    VStack(spacing: 20) {
      Text("tracking 자간")
        .tracking(10)
      Text("tracking 자간")
        .tracking(-1)
      Text("kerning 자간")
        .kerning(10)
      Text("kerning 자간")
        .kerning(-1)
    }
    .padding()
  }
}

#Preview {
    SpacingView()
}
