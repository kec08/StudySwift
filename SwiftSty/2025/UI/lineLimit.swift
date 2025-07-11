//
//  lineLimit.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/14/25.
//

import SwiftUI

struct LineLimitView: View {
  var body: some View {
    Text("line Limit 테스트")
      .bold()
    VStack(spacing: 10) {
      Text("안녕하세요\n김은찬\n입니다")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineLimit(2)
        .background(Color.green)
      Text("안녕하세요\n김은찬\n입니다")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .lineLimit(nil)
        .background(Color.blue)
    }
  }
}

#Preview {
    LineLimitView()
}
