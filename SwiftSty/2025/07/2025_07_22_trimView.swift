//
//  2025_07_22_maskView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/22/25.
//

import SwiftUI

struct trimView: View {
  var body: some View {
    Path { path in
        path.addLines([
            .init(x: 2, y: 1),
            .init(x: 1, y: 0),
            .init(x: 0, y: 1),
            .init(x: 1, y: 2),
            .init(x: 3, y: 0),
            .init(x: 4, y: 1),
            .init(x: 3, y: 2),
            .init(x: 2, y: 1)
        ])
    }
    //trim
    .trim(from: 0.25, to: 1)
    .scale(50, anchor: .topLeading)
    .stroke(Color.black, lineWidth: 3)
  }
}

#Preview{
    trimView()
}
