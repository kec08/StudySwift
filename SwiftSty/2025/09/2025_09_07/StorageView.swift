//
//  StorageView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/6/25.
//

import SwiftUI

struct StorageView: View {
    var body: some View {
        
        SceneStorageView()
            .tabItem {
                Image(systemName: "circle.fill")
                Text("SceeStorage")
            }
        
        AppStorageView()
            .tabItem {
                Image(systemName: "square.fill")
                Text("AppStorage")
            }
        }
    }

