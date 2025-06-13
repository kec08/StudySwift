//
//  adfd.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/13/25.
//

import SwiftUI

struct swipeActions: View {
  @State private var actionTitle = ""

  var body: some View {
    NavigationView {
      List(1..<10) { num in
        Text("리스트 \(num)")
          // 왼쪽에서 스와이프
          .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
              actionTitle = "Counting Star"
            } label: {
              Label("Star", systemImage: "star.circle")
            }
            .tint(.green)
          }

          // 오른쪽에서 스와이프
          .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
              actionTitle = "Move the trash"
            } label: {
              Label("Trash", systemImage: "trash.circle")
            }
            .tint(.red)

            Button {
              actionTitle = "Pick the flag"
            } label: {
              Label("Flag", systemImage: "flag.circle")
            }
            .tint(.blue)
          }
      }
      .navigationTitle("\(actionTitle)")
    }
  }
}

#Preview {
    swipeActions()
}
