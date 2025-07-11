//
//  AnimationsView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/28/25.
//

import SwiftUI

struct AnimationsView: View {
  var xcodeImage: Image
  @State private var selected: Bool = false

  
  var body: some View {
    VStack {
      xcodeImage
        .scaleEffect(selected ? 1.5 : 1.0)
        .onTapGesture {
          withAnimation {
            selected.toggle()
          }
        }
      
      Text("Xcode")
        .font(.title)
    }
    .phaseAnimator([false, true]) { content, phase in
      content
        .foregroundStyle(phase ? .red : .green)
    }
  }
}
