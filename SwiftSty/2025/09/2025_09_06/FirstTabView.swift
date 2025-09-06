//
//  FirstTabView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/6/25.
//

import SwiftUI

struct FirstTabView: View {
    var body: some View {
        Text("First Tab")
            .onAppear(perform: {
                print("onAppear triggered")
            })
            .onDisappear(perform: {
                print("onDisappeared triggered")
            })
    }
}
