//
//  FontMonospacedView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/8/25.
//

import SwiftUI

private struct FontMonospacedView: View {
  @State var num: Int = 100
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Number is")
          .font(.system(size: 32, design: .serif))
        
        Spacer()
        
        Text("\(num)")
          .font(.system(size: 32, design: .monospaced))
          .border(.green)
        
      }
      .border(.red)
      .padding(.horizontal, 70)
      
      Button(
        action: {
          num = .random(in: 100...999)
        },
        label: {
          Text("Change Number")
        }
      )
    }
  }
}

#Preview{
    FontMonospacedView()
}
