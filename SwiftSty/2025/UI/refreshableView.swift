//
//  refreshableView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/23/25.
//

import SwiftUI

struct refreshableView: View {
  @State var colors: [Color] = []

  var body: some View {
    VStack(spacing: 10) {
      Text("Colors")
        .font(.largeTitle)
        .padding(.top, 50)

      List(colors, id: \.self) { color in
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 300, height: 50)
          .foregroundColor(color)
      }
      .onAppear {
        colors = initColors()
      }
      .refreshable {
        await colors.append(contentsOf: addColors())
      }

      Spacer()
    }
  }

  private func initColors() -> [Color] {
    return [.yellow, .green, .indigo, .orange, .purple]
  }

    private func addColors() async -> [Color] {
    return [.red, .blue, .gray]
  }
}

#Preview {
    refreshableView()
}
