//
//  PhaseAnimatorView2.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/2/25.
//

import SwiftUI


enum Phase: CaseIterable {
  case initial
  case move
  case scale
  
  var verticalOffset: Double {
    switch self {
    case .initial:
      return 0
    case .move:
      return -100
    case .scale:
      return -100
    }
  }
  
  var scale: Double {
    switch self {
    case .initial:
      return 1.0
    case .move:
      return 1.0
    case .scale:
      return 2.0
    }
  }
}

private struct PhaseAnimatorView2: View {
  
  @State private var selected: Bool = false
  
  var body: some View {
      Image("Qiri")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
      .onTapGesture {
        withAnimation {
          selected.toggle()
        }
      }
      .phaseAnimator(
        Phase.allCases,
        trigger: selected
      ) { content, phase in
        content
          .scaleEffect(phase.scale)
          .offset(y: phase.verticalOffset)
      } animation: { phase in
        switch phase {
        case .initial: .smooth
        case .move: .easeInOut(duration: 0.3)
        case .scale: .spring(
          duration: 0.3,
          bounce: 0.7
        )
        }
      }
  }
}

#Preview {
    PhaseAnimatorView2()
}
