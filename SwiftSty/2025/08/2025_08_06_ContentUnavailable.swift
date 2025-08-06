//
//  2025_08_06_ContentUnavailable.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/6/25.
//

import SwiftUI

struct ContentUnavailable: View {
  @ObservedObject private var viewModel = ContactsViewModel()
  
  var body: some View {
      NavigationStack {
          List {
              ForEach(viewModel.searchResults) { contact in
                  NavigationLink {
                      ContactsView(contact: contact)
                  } label: {
                      Text(contact.name)
                  }
              }
          }
          .navigationTitle("Contacts")
          .searchable(text: $viewModel.searchText)
//          .overlay {
//              if viewModel.searchResults.isEmpty {
//                  ContentUnavailableView(
//                    label: {
//                        Label(
//                            "No Results for \(viewModel.searchText)",
//                            systemImage: "magnifyingglass"
//                        )
//                    },
//                    description: {
//                        Text("Check the spelling or try a new search.")
//                    },
//                    actions: {
//                        Button(action: {}) {
//                            Text("Refresh")
//                        }
//                    }
//                  )
//              }
//          }
          .overlay {
              if viewModel.searchResults.isEmpty {
                  ContentUnavailableView {
                      Label(
                        "\(viewModel.searchText)에 대한 결과가 없습니다.",
                        systemImage: "magnifyingglass"
                      )
                  } description: {
                      Text("맞춤법을 확인하거나 다른 검색어를 입력해보세요")
                  }
                  actions: {
                      Button("새로고침") {
                          // 새로고침 동작
                      }
                  }
              }
          }
      }
  }
}

struct ContactsView: View {
  var contact: Contact
  
  var body: some View {
    Text("Details for \(contact.name)")
  }
}

// Model
class ContactsViewModel: ObservableObject {
  @Published var searchText = ""
  @Published var searchResults: [Contact] = []
}

struct Contact: Identifiable {
  let id = UUID()
  let name: String
}

#Preview {
    ContentUnavailable()
}
