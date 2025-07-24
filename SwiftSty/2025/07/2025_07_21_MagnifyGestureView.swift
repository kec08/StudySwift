//
//  2025_07_21_MagnifyGestureView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/21/25.
//

import SwiftUI

struct MagnifyGestureView: View {
    @State private var scale = 3.0
    @GestureState private var magnification = 1.0

    var magnificationGesture: some Gesture {
        MagnifyGesture()
            .updating($magnification) { value, gestureState, _ in
                gestureState = value.magnification
            }
            .onEnded { value in
                self.scale *= value.magnification
            }
    }

    var body: some View {
        Circle()
            .fill(.green)
            .frame(width: 100, height: 100)
            .scaleEffect(scale * magnification)
            .gesture(magnificationGesture)
    }
}


#Preview{
    MagnifyGestureView()
}
