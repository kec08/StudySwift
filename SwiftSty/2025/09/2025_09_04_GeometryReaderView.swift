//
//  2025_09_04_GeometryReaderView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/4/25.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<20) { index in
                GeometryReader { geometry in
                    let y = geometry.frame(in: .global).minY
                    
                    Circle()
                        .fill(y < 200 ? Color.red : Color.blue)
                        .frame(width: 100, height: 100)
                        .overlay(Text("\(index)"))
                }
                .frame(height: 120)
            }
        }
        
//            GeometryReader { geometry in
//                let isWide = geometry.size.width > 400
//                
//                HStack {
//                    if isWide {
//                        Text("넓은 화면: HStack 배치")
//                        Spacer()
//                        Image(systemName: "rectangle.split.3x1")
//                    } else {
//                        VStack {
//                            Text("좁은 화면: VStack 배치")
//                            Image(systemName: "rectangle.split.3x1")
//                        }
//                    }
//                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
//                .background(Color.yellow.opacity(0.3))
//            }
        }
}


#Preview {
    GeometryReaderView()
}
