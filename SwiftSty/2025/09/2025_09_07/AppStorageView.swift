//
//  AppStorageView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/7/25.
//

import SwiftUI

struct AppStorageView: View {
    
    @AppStorage("mytext") var editorText: String = "Sample Text"
    
    var body: some View {
        TextEditor(text: $editorText)
            .padding(30)
            .font(.largeTitle)
    }
}
