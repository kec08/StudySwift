//
//  LazyHGridView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/21/25.
//

import SwiftUI

struct LazyHGridView: View {
  let rows = [GridItem(.flexible())]
  let colors: [Color] = [.black, .blue, .brown, .cyan, .gray, .indigo, .mint, .yellow, .orange, .purple]
  
  var body: some View {
    ScrollView(.horizontal) {
      LazyHGrid(rows: rows) {
        ForEach(colors, id: \.self) { color in
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 450)
            .foregroundColor(color)
        }
      }
    }
    .padding()
  }
}

#Preview {
    LazyHGridView()
}
