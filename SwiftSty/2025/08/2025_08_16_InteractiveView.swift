//
//  2025_08_16_InteractiveView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/16/25.
//

import SwiftUI

struct InteractiveView: View {
  @State private var isTopViewSelected = false
  @State private var isBottomViewSelected = false
  
  var body: some View {
    ZStack {
      // 배경
      if isTopViewSelected {
        Color.blue
          .ignoresSafeArea()
      } else if isBottomViewSelected {
        Color.orange
          .ignoresSafeArea()
      }
      
      
      VStack(spacing: 0) {
        // 상단 뷰
        HStack {
          Spacer()
          
          Button(
            action: {
              withAnimation(.spring(response: 1.0, dampingFraction: 0.7)) {
                isTopViewSelected.toggle()
                isBottomViewSelected = false
              }
            }
          ) {
            Image("Main_Qiri")
              .resizable()
              .frame(
                width: isTopViewSelected ? 300 : 100,
                height: isTopViewSelected ? 300 : 100
              )
          }
          .offset(
            x: isBottomViewSelected ? UIScreen.main.bounds.width + 100 : 0,
            y: isTopViewSelected ?
            UIScreen.main.bounds.height/4 :
              (isBottomViewSelected ? UIScreen.main.bounds.height + 100 : 0)
          )
          
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isTopViewSelected || isBottomViewSelected ? Color.clear : Color.blue)
        
        // 하단 뷰
        HStack {
          Spacer()
          
          Button(
            action: {
              withAnimation(.spring(response: 1.0, dampingFraction: 0.7)) {
                isBottomViewSelected.toggle()
                isTopViewSelected = false
              }
            }
          ) {
            Image("Main_Qiri")
              .resizable()
              .frame(
                width: isBottomViewSelected ? 300 : 100,
                height: isBottomViewSelected ? 300 : 100
              )
          }
          .offset(
            x: isTopViewSelected ? UIScreen.main.bounds.width + 100 : 0,
            y: isBottomViewSelected ?
            -UIScreen.main.bounds.height/4 :
            (isTopViewSelected ? UIScreen.main.bounds.height + 100 : 0)
          )
          
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isTopViewSelected || isBottomViewSelected ? Color.clear : Color.orange)
      }
    }
    .ignoresSafeArea()
  }
}

#Preview {
    InteractiveView()
}
