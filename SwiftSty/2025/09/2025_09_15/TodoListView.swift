//
//  TodoListView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/15/25.
//

import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.todos) { todo in
                    HStack {
                        Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(todo.completed ? .green : .gray)
                        VStack(alignment: .leading) {
                            Text(todo.title)
                                .font(.headline)
                            Text("User ID: \(todo.userId) | Todo ID: \(todo.id)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("POST 테스트") {
                        viewModel.postPost()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchTodos()
        }
    }
}

#Preview {
    TodoListView()
}
