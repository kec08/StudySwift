//
//  2025_07_22_maskView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/22/25.
//

import SwiftUI

struct maskView: View {
  @State private var percent: CGFloat = 0.0
  
  var body: some View {
    VStack {
      Image("apple")
        .resizable()
        .frame(width: 200, height: 200)
        .mask(ProgressBar(value: $percent))
      
      Slider(value: $percent, in: 0...1)
        .padding()
    }
  }
}

struct ProgressBar: View {
  @Binding var value: CGFloat
  
  var body: some View {
    GeometryReader { geometry in
      Rectangle()
        .frame(width: geometry.size.width * value, height: geometry.size.height)
    }
  }
}

#Preview{
    maskView()
}
