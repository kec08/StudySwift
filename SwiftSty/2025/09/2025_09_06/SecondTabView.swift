//
//  SecondTabView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/6/25.
//

import SwiftUI

struct SecondTabView: View {
    @State private var text: String = ""
    
    var body: some View {
        TextEditor(text: $text)
            .padding()
            .onChange(of: text, perform: { value in
                print("onChange triggered")
            })
    }
}

#Preview {
    SecondTabView()
}
