//
//  2025_07_26_blendModeView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/26/25.
//

import SwiftUI

struct blendModeView: View {
  var body: some View {
      HStack {
          Color.yellow.frame(width: 50, height: 50)
          
          Color.red
              .frame(width: 50, height: 50)
              .rotationEffect(.degrees(45))
              .padding(-20)
              .blendMode(.colorBurn)

      }
      
      HStack {
          Color.red
              .frame(width: 50, height: 50)
              .rotationEffect(.degrees(45))
              .blendMode(.colorBurn)
          
          Color.yellow
              .frame(width: 50, height: 50)
              .padding(-20)
      }

      
      
      
      ZStack {
          Color.black.ignoresSafeArea()
        Circle()
          .fill(.red)
          .frame(width: 200)
          .offset(x: -50, y: -80)
          .blendMode(.screen)
        
        Circle()
          .fill(.green)
          .frame(width: 200)
          .offset(x: 50, y: -80)
          .blendMode(.screen)
        
        Circle()
          .fill(.blue)
          .frame(width: 200)
          .blendMode(.screen)
      }
  }
}

#Preview {
    blendModeView()
}

