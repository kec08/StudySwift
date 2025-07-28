//
//  2025_97_29_PasteButtonView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/29/25.
//

import SwiftUI

struct PasteButtonView: View {
  @State private var pastedText: String = ""
  @State private var inputText: String = ""
  
  var body: some View {
    VStack(spacing: 20) {
      TextField("텍스트를 입력하세요!", text: $inputText)
      
      HStack {
          PasteButton(payloadType: String.self) { strings in
            pastedText = strings[0]
          }
          .buttonBorderShape(.capsule)
          .labelStyle(.iconOnly)
          .tint(.green)
        
        Divider()
        
        Text(pastedText)
        
        Spacer()
      }
    }
    .frame(height: 100)
    .padding(.all)
  }
}

#Preview {
    PasteButtonView()
}
