//
//  onChangeView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/9/25.
//

import SwiftUI
import Combine

struct onChangeView: View {
  let colors: [Color] = (0..<100).map { _ in Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)) }
  
  @State private var isScrolling = false
  @State private var cancellableSet = Set<AnyCancellable>()
  @State private var scrollSubject = CurrentValueSubject<Bool, Never>(false)
  
  var body: some View {
    VStack(spacing : 10) {
      Text(isScrolling ? "진행중" : "종료")
        .font(.title)
      
      ScrollView {
        VStack(spacing : 10) {
          ForEach(colors, id:\.self) { color in
            Rectangle()
              .fill(color)
              .frame(height : 50)
              .cornerRadius(10)
              .padding(.horizontal, 10)
          }
        }
        .background(
          GeometryReader { geometry in
            Color.clear
              .onChange(of : geometry.frame(in:.global)) { geometry in
                let scrollViewEnd = geometry.maxY
                let screenHeight = UIScreen.main.bounds.height
                
                scrollSubject.send(screenHeight < scrollViewEnd)
              }
          }
        )
        
      }
      .onAppear {
        scrollSubject
          .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
          .sink { self.isScrolling = $0 }
          .store(in: &cancellableSet)
      }
    }
  }
}

#Preview {
    onChangeView()
}
