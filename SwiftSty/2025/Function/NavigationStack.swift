//
//  NavigationStack.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import SwiftUI

struct NavigationStackView: View {
  var body: some View {
    NavigationStack {
      NavigationLink("Go to Child View", value: "10")
        .navigationDestination(for: String.self) { value in
          Text("Child Number is \(value)")
        }
    }
  }
}

#Preview {
    NavigationStackView()
}
