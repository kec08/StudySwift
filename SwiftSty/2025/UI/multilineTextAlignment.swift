//
//  multilineTextAlignment.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/14/25.
//

import SwiftUI

struct MultiLineView: View {
  var body: some View {
    Text("multiLine Text Alignment 연습")
          .padding(10)
      .bold()
    VStack(spacing: 10) {
      Text("안녕하세요 제 이름은\n김은찬\n입니다")
        .frame(alignment: .leading)
        .multilineTextAlignment(.leading)
        .background(Color.yellow)
      
      Text("안녕하세요 제 이름은\n홍길동\n입니다")
        .frame(alignment: .leading)
        .multilineTextAlignment(.trailing)
        .background(Color.blue)
      
      Text("안녕하세요 제 이름은\n김떙땡\n입니다")
        .frame(alignment: .leading)
        .multilineTextAlignment(.center)
        .background(Color.pink)
    }
  }
}

#Preview {
    MultiLineView()
}
