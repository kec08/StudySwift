//
//  2025_07_30_DragDropView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/30/25.
//

import SwiftUI

struct DragDropView: View {
  var content: String = "green"
  @State private var dropText: String = "Drop Here"
  @State private var isDisplayGreenRectangle: Bool = true
  
  var body: some View {
    VStack(spacing: 50) {
      if isDisplayGreenRectangle {
        Color.green
          .frame(width: 200, height: 200)
          .draggable(content) {
            Text(content)
              .background(Color.green)
          }
      }
      
      Text(dropText)
        .font(.title)
        .frame(width: 200, height: 200)
        .border(.black)
        .background(isDisplayGreenRectangle ? .white : .green)
        .dropDestination(for: String.self) { receivedTitles, location in
          process(titles: receivedTitles)
          return true
        }
    }
  }
  
  func process(titles: [String]) {
    withAnimation {
      dropText = titles.first ?? "What"
      isDisplayGreenRectangle.toggle()
    }
  }
}

#Preview {
    DragDropView()
}
