//
//  2025_08_07_symbolEffectView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/7/25.
//

import SwiftUI

struct symbolEffectView: View {
  @State private var counter: Int = 0
  
  var body: some View {
    VStack {
      Button(
        action: { counter += 1 },
        label: {
          Text("Tap Tap!")
        }
      )
      
      Image(systemName: "square.and.arrow.up")
        .resizable()
        .frame(width: 150, height: 100)
        .symbolEffectsRemoved()
      
      Image(systemName: "folder.fill.badge.person.crop")
        .resizable()
        .frame(width: 150, height: 100)
    }
    .symbolEffect(.bounce, value: counter)
    .symbolEffect(.pulse, options: .repeating, value: counter)
  }
}

#Preview {
    symbolEffectView()
}
