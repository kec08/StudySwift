//
//  2025_09_06_LifecycleView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/6/25.
//


import SwiftUI

@main
struct LifecycleView: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase, perform:  { phase in
            switch phase {
            case .active:
                print("Active")
            case .inactive:
                print("Inactive")
            case .background:
                print("Background")
            default:
                print("Unknown sxenephase")
            }
        })
    }
}

