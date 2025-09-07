//
//  ListView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/8/25.
//

//
//  ListView.swift
//  ConcurrencyDemo
//
//  Created by 김은찬 on 9/7/25.
//

import SwiftUI

struct ToDoItem: Identifiable {
    var id = UUID()
    var task: String
    var imageName: String
}

struct ListView: View {
    
    @State private var listData: [ToDoItem] = [
        ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
        ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
        ToDoItem(task: "Wash the car", imageName: "car.fill")
    ]
    
    @State private var stackPath = NavigationPath()
    @State private var toggleStatus = true
    
    var body: some View {
        
        NavigationStack(path: $stackPath) {
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notifications")
                    }
                    
                    NavigationLink(value: listData.count) {
                        Text("View Task Count")
                    }
                }
                
                Section(header: Text("To Do Tasks")) {
                    ForEach(listData) { item in
                        NavigationLink(value: item.task) {
                            HStack {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addTask) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(for: String.self) { task in
                Text("Selected task = \(task)")
            }
            .navigationDestination(for: Int.self) { count in
                Text("Number of tasks = \(count)")
            }
        }
    }
    
    // MARK: - 편집 기능
    
    func deleteItem(at offsets: IndexSet) {
        listData.remove(atOffsets: offsets)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        listData.move(fromOffsets: source, toOffset: destination)
    }
    
    func addTask() {
        let newTask = ToDoItem(task: "New Task", imageName: "plus.circle.fill")
        listData.append(newTask)
    }
}

#Preview {
    ListView()
}

