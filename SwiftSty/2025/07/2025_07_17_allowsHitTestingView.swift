//
//  2025_07_17_ allowsHitTestingView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/17/25.
//

import SwiftUI

//struct allowsHitTestingView: View {
//  @State var isDisplayText: Bool = false
//  
//  var body: some View {
//    VStack {
//      Text("Green")
//        .font(.title)
//        .bold()
//        .foregroundColor(.green)
//        .opacity(isDisplayText ? 1 : 0)
//      
//      ZStack {
//        Rectangle()
//          .fill(.green)
//          .cornerRadius(10)
//          .frame(width : 100, height: 100)
//          .onTapGesture {
//            isDisplayText.toggle()
//          }
//        
//        Rectangle()
//          .fill(.red)
//          .cornerRadius(10)
//          .frame(width : 50, height: 50)
//          .allowsHitTesting(false)
//      }
//    }
//  }
//}
struct allowsHitTestingView: View {
  @State var isDisplayText: Bool = false
  
  var body: some View {
    VStack {
      Text("Green")
        .font(.title)
        .bold()
        .foregroundColor(.green)
        .opacity(isDisplayText ? 1 : 0)
      
      ZStack {
        Rectangle()
          .fill(.green)
          .cornerRadius(10)
          .frame(width : 100, height: 100)
          .onTapGesture {
            isDisplayText.toggle()
          }
        
        Image(systemName: "car.2.fill")
          .frame(width: 50, height: 50)
          .onTapGesture {
            // code
          }
          // 필요에 따라 적용
          .allowsHitTesting(false)
      }
    }
  }
}

#Preview {
    allowsHitTestingView()
}
