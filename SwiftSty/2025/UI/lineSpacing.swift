//
//  lineSpacing.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/14/25.
//

import SwiftUI

struct LineSpacingView: View {
  var body: some View {
    Text("line Spacing Test")
      .font(.largeTitle)
      .bold()
    VStack(spacing: 10) {
      Text("안녕하세요\n김은찬\n입니다")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineSpacing(10)
        .background(Color.green)

      Text("안녕하세요\n김은찬\n입니다")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineSpacing(50)
        .background(Color.blue)
    }
  }
}

#Preview {
    LineSpacingView()
}

