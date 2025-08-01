//
//  2025_07_30_DragDropView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/30/25.
//

import SwiftUI

struct DragDropView: View {
    var content = "ssilvv"
      @State private var dropText = "Drop Here"
      @State private var showGreenBox = true

      var body: some View {
        VStack(spacing: 50) {
          if showGreenBox {
            Color.gray
              .frame(width: 200, height: 200)
              .draggable(content) {
                Text("📱 \(content)")
                  .padding()
                  .background(Color.gray)
              }
          }

          Text(dropText)
            .font(.title)
            .frame(width: 200, height: 200)
            .border(.black)
            .background(showGreenBox ? Color.white : Color.gray)
            .dropDestination(for: String.self) { items, location in
              withAnimation {
                dropText = items.first ?? "What"
                showGreenBox = false
              }
              return true
            }
        }
        .padding()
      }
  }

#Preview {
    DragDropView()
}
