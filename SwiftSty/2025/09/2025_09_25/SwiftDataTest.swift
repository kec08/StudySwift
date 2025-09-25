//
//  SwiftDataTest.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/25/25.
//

import Foundation
import SwiftData

@Model
class TodoItem {
    var title: String
    var isDone: Bool
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}

struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // TodoItem 모델을 위한 컨테이너 등록
        .modelContainer(for: TodoItem.self)
    }
}

import SwiftUI
import SwiftData

struct SwiftDataTest: View {
    // 데이터 읽기: 자동으로 TodoItem들을 불러옴
    @Query var todos: [TodoItem]
    
    // 쓰기 작업을 위한 context
    @Environment(\.modelContext) private var context
    
    @State private var newTitle: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    HStack {
                        Text(todo.title)
                        Spacer()
                        if todo.isDone {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                    .onTapGesture {
                        // 완료 상태 토글
                        todo.isDone.toggle()
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(todos[index])
                    }
                }
            }
            .navigationTitle("SwiftData Todo")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        TextField("할 일 입력", text: $newTitle)
                            .textFieldStyle(.roundedBorder)
                        Button("추가") {
                            let newTodo = TodoItem(title: newTitle)
                            context.insert(newTodo)
                            newTitle = ""
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SwiftDataTest()
}
