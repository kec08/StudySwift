//
//  parentsView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/3/25.
//

import SwiftUI

struct ParentsView: View {
    @State private var isOn: Bool = false
    @State private var isTrue: Bool = false
    @State private var navigate: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("삭제 버튼") {
                }
                .navigationDestination(isPresented: $navigate) {
                    BindingView(isTrue: $isTrue)
                }
            }
            .alert("옵션 선택", isPresented: $isOn) {
                Button("삭제", role: .destructive) {
                    print("삭제 선택")
                    isTrue = true
                    navigate = true
                }
                Button("취소", role: .cancel) { }
            } message: {
                Text("정말 삭제하시겠습니까?")
            }
        }
    }
}

#Preview {
    ParentsView()
}

