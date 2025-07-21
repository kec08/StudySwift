//
//  PhaseAnimatorView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/30/25.
//

import SwiftUI

struct PhaseAnimatorView: View {
  @State private var selected: Bool = false

  
  var body: some View {
    VStack {
        Image("Qiri")
              .resizable()
              .scaledToFit()
              .frame(width: 200, height: 200)
        .scaleEffect(selected ? 1.5 : 1.0)
        .onTapGesture {
          withAnimation {
            selected.toggle()
          }
        }
      
      Text("Hello SwiftUI")
        .font(.title)
        .phaseAnimator([false, true]) { content, phase in
            content
                .foregroundStyle(phase ? .red : .blue)
        }
    }
    .phaseAnimator([false, true]) { content, phase in
      content
        .foregroundStyle(phase ? .red : .green)
    }
  }
}

#Preview{
    PhaseAnimatorView()
}
