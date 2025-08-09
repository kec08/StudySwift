//
//  2025_08_10_ScaledMetricView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/10/25.
//

import SwiftUI

struct ScaledMetricView: View {
  @ScaledMetric(relativeTo: .headline) var headline = 150
  @ScaledMetric(relativeTo: .largeTitle) var largeTitle = 150
  
  var body: some View {
    VStack(spacing: 10) {
      Image("apple")
        .resizable()
        .frame(width: headline, height: headline)
      
      Text("Headline")
        .font(.headline)
      
      Image("apple")
        .resizable()
        .frame(width: largeTitle, height: largeTitle)
      
      Text("LargeTitle")
        .font(.largeTitle)
    }
  }
}

#Preview {
    ScaledMetricView()
}
