//
//  DisclosureGroupView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/16/25.
//

import SwiftUI

struct DisclosureGroupView: View {
  @State private var expanded: Bool = false

  var body: some View {
    DisclosureGroup("Root", isExpanded: $expanded) {
      Text("Swift")
      DisclosureGroup("SwifUI") {
        Text("DisclosureGroup")
      }
    }
  }
}

#Preview {
    DisclosureGroupView()
}
