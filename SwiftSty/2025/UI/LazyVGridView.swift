//
//  LazyVGridView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/21/25.
//

import SwiftUI

struct VazeVGridView: View {
  let columns = [GridItem(.flexible()), GridItem(.flexible(), spacing: 50)]
  let colors: [Color] = [.black, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
  
  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(colors, id: \.self) { color in
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 150, height: 100)
          .foregroundColor(color)
      }
    }
    .padding()
  }
}

#Preview {
    VazeVGridView()
}
