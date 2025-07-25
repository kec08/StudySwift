//
//  2025_07_25_compositingGroupView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/25/25.
//

import SwiftUI

struct compositingGroupView: View {
  var body: some View {
      ZStack {
          Rectangle()
              .fill(Color.green)
              .frame(width: 150, height: 150)
          
          Rectangle()
              .fill(Color.yellow)
              .frame(width: 150, height: 150)
              .offset(x: 100)
      }
      .opacity(0.5)
      

      ZStack {
          Text("SwiftUI")
              .foregroundColor(.white)
              .padding()
              .background(Color.blue)

          Text("SwiftUI")
              .blur(radius: 3)
      }
      .padding(.top, 30)
      .padding(.bottom, 30)
      .compositingGroup()
      .opacity(0.6)

      
      VStack {
        ZStack {
          Text("CompositingGroup")
            .foregroundColor(.black)
            .padding(20)
            .background(Color.red)
            
          Text("CompositingGroup")
            .blur(radius: 2)
        }
        .font(.largeTitle)
        .compositingGroup()
        .opacity(0.9)
      }
      
    ZStack {
      Rectangle()
        .frame(width: 150, height: 150)
        .foregroundColor(.green)
      
      Rectangle()
        .frame(width: 150, height: 150)
        .foregroundColor(.yellow)
        .offset(x: 100)
    }
    .compositingGroup()
    .opacity(0.3)
  }
}

#Preview {
    compositingGroupView()
}
