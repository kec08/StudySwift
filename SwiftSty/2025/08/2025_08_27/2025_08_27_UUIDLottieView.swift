//
//  2025_08_27_UUIDLottieView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/27/25.
//

import SwiftUI
import Lottie

struct UUIDLottieView: View {
  @State var isGrowUp: Bool = false
  var actionBtnText: String {
    isGrowUp ? "rejuvenate" : "Grow Up"
  }
  @State private var lottieID = UUID()
  
  var body: some View {
    NavigationView {
      VStack {
        Text("Here is FirstView")
          .font(.title)
          .padding()
        
        Spacer()
        
        if isGrowUp {
          LottieView(animation: "Ai_loading")
            .frame(width: 200, height: 200)
            .id(lottieID)
        } else {
          LottieView(animation: "rocket_icon")
            .frame(width: 200, height: 200)
            .id(lottieID)
        }
        
        Button(
          action: {
            isGrowUp.toggle()
          },
          label: {
            Text(actionBtnText)
          }
        )
        
        Spacer()
        
        NavigationLink(destination: SecondView()) {
          Text("Move to the SecondView")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
      }
      .onAppear {
        lottieID = UUID()
      }
      .navigationTitle("FirstView")
    }
  }
}

#Preview {
    UUIDLottieView()
}