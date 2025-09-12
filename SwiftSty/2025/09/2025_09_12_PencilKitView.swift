//
//  2025_09_12_PencilKitView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/13/25.
//

import SwiftUI
import PencilKit

struct PencilKitView: View {
    let canvas = PKCanvasView()
    let toolPicker = PKToolPicker()

    @State private var showsToolPicker: Bool = true

    var body: some View {
        NavigationView {
            CanvasView(canvas: canvas, toolPicker: toolPicker)
                .navigationTitle("Canvas")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            toolPickerToggle()
                        }) {
                            Text(showsToolPicker ? "Show" : "Draw")
                        }
                    }
                }
                .scaleEffect(showsToolPicker ? 0.75 : 1, anchor: .init(x: 0.5, y: 0.2))
        }
    }

    private func toolPickerToggle() {
        toolPicker.setVisible(!toolPicker.isVisible, forFirstResponder: canvas)
        withAnimation {
            showsToolPicker.toggle()
        }
    }
}

struct DrawingCanvas_Previews: PreviewProvider {
    static var previews: some View {
        PencilKitView()
    }
}

struct CanvasView: UIViewRepresentable {
    let canvas: PKCanvasView
    let toolPicker: PKToolPicker
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.isOpaque = false
        canvas.backgroundColor = .blue.withAlphaComponent(0.5)
        
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}
