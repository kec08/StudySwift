//
//  SceneStorageView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/6/25.
//

import SwiftUI

struct SceneStorageView: View {
    
    @SceneStorage("mytext") private var editorText = ""
    
    var body: some View {
        TextEditor(text: $editorText)
            .padding(30)
            .font(.largeTitle)
    }
}
