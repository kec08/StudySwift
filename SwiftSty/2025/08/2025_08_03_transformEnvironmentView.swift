//
//  2025_08_03_transformEnvironmentView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/3/25.
//

import SwiftUI

import SwiftUI

//struct EnvironmentView: View {
//  @Environment(\.colorScheme) var colorScheme
//
//  var body: some View {
//    Text("silver")
//      .foregroundColor(colorScheme == .dark ? .green : .blue)
//  }
//}

struct transformEnvironmentView: View {
  var body: some View {
    VStack(spacing: 20) {
      Text("Parent")
      
      ChildView()
        .transformEnvironment(\.font) { font in
          font = Font.system(size: 30)
        }
    }
  }
}

struct ChildView: View {
  var body: some View {
    Text("Child")
  }
}

#Preview {
    transformEnvironmentView()
}
