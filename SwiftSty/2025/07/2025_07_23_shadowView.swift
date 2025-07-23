//
//  2025_07_23_shadowView
//  SwiftSty
//
//  Created by 김은찬 on 7/23/25.
//

import SwiftUI

struct shadowView: View {
    let steps = [0, 10, 20]
    
    var body: some View {
        VStack(spacing: 50) {
            ForEach(steps, id: \.self) { offset in
                HStack(spacing: 50) {
                    ForEach(steps, id: \.self) { radius in
                        Color.green
                            .frame(width: 60, height: 60)
                            .shadow(
                                color: .gray,
                                radius: CGFloat(radius),
                                x: CGFloat(offset),
                                y: CGFloat(offset)
                            )
                            .overlay {
                                VStack {
                                    Text("R:\(radius)")
                                    Text("(\(offset), \(offset))")
                                }
                                .foregroundColor(.black)
                                .font(.caption)
                            }
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    shadowView()
}
