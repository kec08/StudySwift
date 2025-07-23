//
//  2025_07_23_blurView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/23/25.
//

import SwiftUI

struct blurView: View {
  var body: some View {
    VStack {
      Text("Hi Swift!")
        .blur(radius: 3, opaque: true)
      
      Text("Hi eunchan!")
        .blur(radius: 3)
      
      Color.gray
        .frame(width: 50, height: 50)
        .blur(radius: 3)
    }
  }
}

#Preview {
    blurView()
}
