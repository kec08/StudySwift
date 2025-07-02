//
//  KeyframesView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/2/25.
//

import SwiftUI

struct AnimationValues {
  var scale = 1.0
  var verticalStretch = 1.0
  var verticalTranslation = 0.0
  var angle = Angle.zero
}

private struct KeyframesView: View {
  
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
      .keyframeAnimator(
        initialValue: AnimationValues(),
        trigger: selected
      ) { content, value in
        content
          .rotationEffect(value.angle)
          .scaleEffect(value.scale)
          .scaleEffect(y: value.verticalStretch)
          .offset(y: value.verticalTranslation)
      } keyframes: { _ in
        KeyframeTrack(\.scale) {
          LinearKeyframe(1.0, duration: 0.5)
          SpringKeyframe(1.5, duration: 0.8, spring: .bouncy)
          SpringKeyframe(1.0, spring: .bouncy)
        }
      }
  }
}

#Preview {
    KeyframesView()
}
