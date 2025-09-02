//
//  2025_09_03_PerformanceTestView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/3/25.
//

import SwiftUI

// 성능 측정을 위한 테스트용 SwiftUI 뷰
struct PerformanceTestView: View {
    @State private var isAnimating = false
    @State private var items: [UUID] = (0..<100).map { _ in UUID() }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 2) {
                ForEach(items, id: \.self) { item in
                    AnimatedCard(isAnimating: isAnimating)
                }
            }
        }
        .onAppear {
            // 애니메이션 성능 테스트 시작
            withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                isAnimating.toggle()
            }
        }
    }
}

struct AnimatedCard: View {
    let isAnimating: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .frame(height: 60)
            .scaleEffect(isAnimating ? 1.05 : 1.0)
            .opacity(isAnimating ? 0.8 : 1.0)
            .padding(.horizontal)
    }
}

#Preview{
    PerformanceTestView()
}
