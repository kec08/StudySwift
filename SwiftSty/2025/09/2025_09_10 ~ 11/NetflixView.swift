//
//  NetflixView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

struct NetflixView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .toolbarBackground(.black, for: .tabBar)
            
            Text("2탭화면")
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Game")
                }
            
            Text("3탭화면")
                .tabItem {
                    Image(systemName: "play.rectangle.on.rectangle")
                    Text("New & Hot")
                }
            
            Text("4탭화면")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("User")
                }
        }
    }
}

#Preview {
    NetflixView()
}
