//
//  ScrollViewReader.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/16/25.
//

import SwiftUI

struct ScrollViewReaderExample: View{
    @Namespace var topID
    @Namespace var bottomID

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Button("밑으로 이동하기!") {
                    withAnimation {
                        proxy.scrollTo(bottomID)
                    }
                }
                .id(topID)

                VStack(spacing: 0) {
                    ForEach(0..<100) { i in
                        color(fraction: Double(i) / 100)
                            .frame(height: 32)
                    }
                }

                Button("위로 이동하기!") {
                    withAnimation {
                        proxy.scrollTo(topID)
                    }
                }
                .id(bottomID)
            }
        }
    }

    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}

#Preview {
    ScrollViewReaderExample()
}
