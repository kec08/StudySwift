//
//  2025_08_08_ViewThatFitsView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/8/25.
//

import SwiftUI

struct ViewThatFitsView: View {
  var uploadProgress: Double = 0.7
  
  var body: some View {
    ViewThatFits {
//        HStack(spacing: 10) {
//                Text("가로로 나타내보자")
//                  .font(.title)
//                
//                Text("가로로 길게 길게 길게 나타내보자!")
//                  .font(.body)
//              }
//              
//        VStack(spacing: 10) {
//                Text("세로로 나타내보자")
//                  .font(.title)
//                
//                Text("세로로 나타내보자!")
//                  .font(.body)
//              }
      HStack {
        Text("\(uploadProgress.formatted(.percent))")
        
        ProgressView(value: uploadProgress)
          .frame(width: 100)
      }
      
      ProgressView(value: uploadProgress)
        .frame(width: 100)
      
      Text("\(uploadProgress.formatted(.percent))")
    }
  }
}
#Preview {
    ViewThatFitsView()
}
