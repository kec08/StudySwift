//
//  MonospacedView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/8/25.
//

import SwiftUI

private struct MonospacedView: View {
  @State var num: Int = 100
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Number is")
          .font(.system(size: 32))
        
        Spacer()
        
        Text("\(num)")
          .font(.system(size: 32))
          .border(.green)
        
      }
      .border(.red)
      .padding(.horizontal, 70)
      .monospaced()
      
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

#Preview {
    MonospacedView()
}
