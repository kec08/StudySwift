//
//  2025_08_13_NavigationTransitionView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/13/25.
//

import SwiftUI

struct NavigationTransitionView: View {
  @Namespace private var namespace
  var body: some View {
    NavigationStack {
      NavigationLink {
        DetailView()
          .navigationTransition(.zoom(sourceID: "detail", in: namespace))
      } label: {
        Text("Go Detail")
          .matchedTransitionSource(id: "detail", in: namespace)
      }
    }
  }
}

struct DetailView: View {
  var body: some View {
    Text("Detail")
  }
}

#Preview {
    NavigationTransitionView()
}
