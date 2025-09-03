//
//  BindingView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/3/25.
//

import SwiftUI

struct BindingView: View {
    @Binding var isTrue: Bool
    
    var body: some View {
        VStack {
            if isTrue {
                Text("삭제됨")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            } else {
                Text("false")
            }
        }
        .navigationTitle("BindingView")
    }
}
