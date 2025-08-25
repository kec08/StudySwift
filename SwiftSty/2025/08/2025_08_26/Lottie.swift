//
//  Lottie.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/26/25.
//

import SwiftUI

struct Lottie: View {
  var body: some View {
    LottieView(animation: "rocket")
      .frame(width: 400, height: 400)
  }
}

#Preview {
    Lottie()
}
