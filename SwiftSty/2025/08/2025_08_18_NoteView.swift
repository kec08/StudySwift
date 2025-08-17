//
//  2025_08_18_NoteView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/18/25.
//

import SwiftUI

struct Note: Identifiable {
  var id: UUID
  var content: String
  
  init(content: String) {
    self.id = UUID()
    self.content = content
  }
}


struct NoteItem: View {
  let content: String
  
  var body: some View {
    HStack(spacing: 30) {
      Circle()
        .fill(Color.green)
        .frame(width: 20, height: 20)
        .overlay(
          Circle()
            .stroke(
              Color.green.opacity(0.3),
              lineWidth: 2
            )
        )
      
      Text(content)
        .font(.title)
        .foregroundColor(.black)
      
      Spacer()
    }
  }
}

struct NoteView: View {
  @State var notes: [Note] = [
    .init(content: "밀린 블로그 포스팅 하기"),
    .init(content: "데드라인 임박한 프로젝트 끝내기"),
    .init(content: "잠 8시간 이상 자기"),
    .init(content: "맥북 수리하기"),
    .init(content: "운동하기"),
    .init(content: "여행 짐 꾸리기"),
    .init(content: "인테리어 시공하기")
  ]
  
  var body: some View {
    ScrollView {
      ZStack {
//        RoundedRectangle(cornerRadius: 12)
//          .stroke(
//            Color.black,
//            lineWidth: 2
//          )
//          .padding(.horizontal, 10)
          
          GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 12)
                      .stroke(
                        Color.black,
                        lineWidth: 2
                      )
                      .padding(.horizontal, 10)
                      .frame(height: geometry.size.height)
                  }
        
        VStack(
          alignment: .leading,
          spacing: 10
        ) {
          Spacer()
            .frame(height: 10)
          
          ForEach(notes, id: \.id) { note in
            NoteItem(content: note.content)
            
            Rectangle()
              .fill(.gray)
              .frame(height: 1)
              .padding(.horizontal, 20)
          }
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

#Preview {
    NoteView()
}
