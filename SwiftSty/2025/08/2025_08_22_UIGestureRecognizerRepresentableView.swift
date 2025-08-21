//
//  2025_08_22_UIGestureRecognizerRepresentableView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/22/25.
//

import SwiftUI

struct MultiTapGesture: UIGestureRecognizerRepresentable {
  let action: () -> Void
  
  func makeUIGestureRecognizer(context: Context) -> some UIGestureRecognizer {
    let gesture = UITapGestureRecognizer()
    gesture.numberOfTouchesRequired = 2
    gesture.delegate = context.coordinator
    return gesture
  }

  func makeCoordinator(converter _: CoordinateSpaceConverter) -> Coordinator {
    Coordinator()
  }

  func handleUIGestureRecognizerAction(
    _ recognizer: UIGestureRecognizerType, context _: Context
  ) {
    switch recognizer.state {
    case .ended:
      action()
    default:
      break
    }
  }

  class Coordinator: NSObject, UIGestureRecognizerDelegate {
    @objc
    func gestureRecognizer(
      _: UIGestureRecognizer,
      shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer
    ) -> Bool {
      true
    }
  }
}


struct UIGestureRecognizerRepresentableView: View {
  @State var text: String = ""
  
  var body: some View {
    Text(text)
      .frame(width: 300, height: 300)
      .background(Color.green)
      .onTapGesture {
        text = "Just Tap"
      }
      .gesture(
        MultiTapGesture {
          text = "Multi Tap"
        }
      )
  }
}

#Preview {
    UIGestureRecognizerRepresentableView()
}
