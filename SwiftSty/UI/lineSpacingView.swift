//
//  lineSpacingView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import SwiftUI

struct lineSpacingView: View {
  var body: some View {
    VStack(spacing: 20) {
      Text("안녕하세요\n김은찬입니다\n안녕히가세요")
        .lineSpacing(10)
      
      Text("안녕하세요\n김은찬입니다\n안녕히가세요")
        .lineSpacing(-1)
    }
    .padding()
  }
}

#Preview{
    lineSpacingView()
}
