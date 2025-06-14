//
//  TabView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
  var body: some View {
    TabView(selection: $selection) {
        
      Text("메인")
            .badge(10)
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("메인")
        }
        .tag(1)
      Text("홈")
            .badge(20)
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("홈")
        }
        .tag(2)
      Text("설정")
            .badge(30)
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("설정")
        }
        .tag(3)
    }
    .accentColor(.orange)
    .font(.headline)
  }
}

#Preview {
    ContentView()
}
