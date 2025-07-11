//
//  renderingModeView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/22/25.
//

import SwiftUI

struct renderingModeView: View {
  var body: some View {
      VStack {
          Spacer()
          Button(
            action: { },
            label: {
                Image("Main_Qiri")
                    .renderingMode(.original)
            }
          )
          
          Spacer()
          
          Button(
            action: { },
            label: {
                Image("Main_Qiri")
                    .renderingMode(.template)
            }
          )
          Spacer()
      }
      .frame(maxWidth: .infinity)
      .background(Color.gray)
      
    .padding()
  }
}

#Preview {
    renderingModeView()
}
