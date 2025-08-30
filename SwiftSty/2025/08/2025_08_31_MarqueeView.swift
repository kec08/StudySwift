//
//  2025_08_31_MarqueeView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/31/25.
//

import SwiftUI

struct MarqueeView: View {
  let text: String
  let speed: Double
  @State private var offset: CGFloat = 0
  @State private var textWidth: CGFloat = 0
  @State private var containerWidth: CGFloat = 0
  @State private var isReady: Bool = false
  
  var body: some View {
    GeometryReader { geometry in
      let containerWidth = geometry.size.width
      
      ZStack(alignment: .leading) {
        // 텍스트 측정용 뷰
        Text(text)
          .font(.system(size: 50))
          .bold()
          .foregroundStyle(.green)
          .fixedSize(horizontal: true, vertical: false)
          .opacity(0)
          .background(
            GeometryReader { textGeometry in
              Color.clear
                .onAppear {
                  textWidth = textGeometry.size.width
                  self.containerWidth = containerWidth
                  isReady = true
                  startMarquee()
                }
            }
          )
        
        // 실제 보여지는 마퀴 뷰
        if isReady {
          HStack(spacing: 0) {
            ForEach(0..<calculateRepeats(), id: \.self) { _ in
              Text(text)
                .font(.system(size: 50))
                .bold()
                .foregroundStyle(.green)
                .fixedSize(horizontal: true, vertical: false)
            }
          }
          .offset(x: offset)
        }
      }
    }
    .clipped()
  }
  
  // 필요한 반복 횟수를 계산하는 함수
  private func calculateRepeats() -> Int {
    guard textWidth > 0 else { return 3 }
    
    // 컨테이너를 채우기 위해 필요한 텍스트 인스턴스 수 계산
    let repeatsNeeded = ceil(containerWidth / textWidth)
    
    // 짧은 텍스트의 경우 최소 3번 반복하고, 긴 텍스트는 필요한만큼 + 1개 추가
    return max(3, Int(repeatsNeeded) + 1)
  }
  
  private func startMarquee() {
    guard textWidth > 0 else { return }
    
    // 텍스트가 컨테이너보다 짧을 경우 자연스러운 속도로 조정
    let animationWidth = textWidth
    let duration = speed * Double(animationWidth / containerWidth * 2)
    
    withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
      offset = -textWidth
    }
  }
}

#Preview {
    MarqueeView(text: "Hello, World!", speed: 2.0)
}
