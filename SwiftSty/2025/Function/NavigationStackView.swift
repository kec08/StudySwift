//
//  NavigationStackView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import SwiftUI

struct NavigationStackView: View {
    @State var stack = NavigationPath()
    
    //기본 코드
    //  var body: some View {
    //    NavigationStack {
    //      NavigationLink("시작페이지", value: "10")
    //        .navigationDestination(for: String.self) { value in
    //          Text("Child Number is \(value)")
    //        }
    //    }
    //  }
    
    //stack을 활용한 코드
    //    var body: some View {
    //        NavigationStack(path: $stack) {
    //          NavigationLink("시작페이지", value: "10")
    //            .navigationDestination(for: String.self) { value in
    //              Text("페이지: \(value)")
    //
    //              Button("뒤로") {
    //                stack.removeLast()
    //              }
    //            }
    //        }
    //      }
    
    //root로 한번에 이동되는 코드
    var body: some View {
        NavigationStack(path: $stack) {
            NavigationLink("시작페이지", value: "10")
                .navigationDestination(for: String.self) { value in
                    VStack {
                        NavigationLink("한 스택 더 들어가기", value: "20")
                        
                        Text("페이지: \(value)")
                        
                        Button("한 스택 뒤로가기") {
                            stack.removeLast()
                        }
                        
                        Button("루트 스택으로 이동") {
                            stack = .init()
                        }
                    }
                }
        }
    }
}

#Preview {
    NavigationStackView()
}
