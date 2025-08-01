//
//  2025_08_02_DisclosureTableView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/2/25.
//

import SwiftUI

// Data
struct DisclosurePerson: Identifiable, Equatable {
  let id = UUID()
  let name: String
  var city: String
  let hobby: String
  var friends = [DisclosurePerson]()
}

struct DisclosureTableView: View {
  @State var people: [DisclosurePerson] = [
    .init(
      name: "green",
      city: "seoul",
      hobby: "movie",
      friends: [
        .init(name: "brown", city: "osaka", hobby: "football"),
        .init(name: "black", city: "tokyo", hobby: "soccer"),
        .init(name: "white", city: "busan", hobby: "movie"),
        .init(name: "purple", city: "daegu", hobby: "football")
      ]
    ),
    .init(name: "red", city: "tokyo", hobby: "soccer"),
    .init(name: "blue", city: "busan", hobby: "tennis"),
    .init(name: "yellow", city: "ulsan", hobby: "cook")
  ]
  
  @State private var bookmarksExpanded = false
  
  var body: some View {
    Table(of: DisclosurePerson.self) {
      TableColumn("Name", value: \.name)
      TableColumn("City", value: \.city)
      TableColumn("Hobby", value: \.hobby)
    } rows: {
      ForEach(people) { person in
        if person.friends.isEmpty {
          TableRow(person)
        } else {
          DisclosureTableRow(person) {
            ForEach(person.friends)
          }
        }
      }
    }
  }
}

#Preview {
    DisclosureTableView()
}
