//
//  2025_08_28_DynamicTypeSizeView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/28/25.
//

import SwiftUI

struct DynamicTypeSizeView: View {
//  @Environment(\.dynamicTypeSize) var typeSize
//  
//  var body: some View {
//    VStack {
//      Text("Current size: \(typeSize)")
//      
//      Text("Hello, world!")
//        .font(.title)
//        .dynamicTypeSize(...DynamicTypeSize.large)
//    }
//    .padding()
//  }
    
    var body: some View {
        VStack(spacing: 20) {
          Text("Title")
            .font(.title)
            .dynamicTypeSize(.small...DynamicTypeSize.accessibility5)
          
          Text("Body")
            .font(.body)
            .dynamicTypeSize(.small...DynamicTypeSize.medium)
        }
        .padding()
      }
}

#Preview {
    DynamicTypeSizeView()
}
