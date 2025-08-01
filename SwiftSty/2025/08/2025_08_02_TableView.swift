//
//  2025_08_02_TableView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/2/25.
//

import SwiftUI

// Data
struct Person: Identifiable {
  let givenName: String
  let familyName: String
  let emailAddress: String
  let id = UUID()
  
  
  var fullName: String { givenName + " " + familyName }
}

//MARK: 선택가능 뷰
//struct TableView: View {
//  @State private var people = [
//    Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
//    Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
//    Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
//    Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
//  ]
//    
//  @State private var selectedPeople = Set<Person.ID>()
//  
//  var body: some View {
//    Table(people, selection: $selectedPeople) {
//      TableColumn("Given Name", value: \.givenName)
//      TableColumn("Family Name", value: \.familyName)
//      TableColumn("E-Mail Address", value: \.emailAddress)
//    }
//    Text("\(selectedPeople.count) people selected")
//  }
//}

//MARK: 정렬 가능 뷰
//struct TableView: View {
//  @State private var people = [
//    Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
//    Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
//    Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
//    Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
//  ]
//  @State private var sortOrder = [KeyPathComparator(\Person.givenName)]
//  
//  var body: some View {
//    Table(people, sortOrder: $sortOrder) {
//      TableColumn("Given Name", value: \.givenName)
//      TableColumn("Family Name", value: \.familyName)
//      TableColumn("E-Mail address", value: \.emailAddress)
//    }
//    .onChange(of: sortOrder) { _, sortOrder in
//      people.sort(using: sortOrder)
//    }
//  }
//}

//MARK: ios 적용 수평뷰
struct TableView: View {
  @State private var people = [
    Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
    Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
    Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
    Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
  ]
  @State private var sortOrder = [KeyPathComparator(\Person.givenName)]
  
  #if os(iOS)
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  private var isCompact: Bool { horizontalSizeClass == .compact }
  #else
  private let isCompact = false
  #endif
  
  var body: some View {
    Table(people, sortOrder: $sortOrder) {
      TableColumn("Given Name", value: \.givenName) { person in
        VStack(alignment: .leading) {
          Text(isCompact ? person.fullName : person.givenName)
          if isCompact {
            Text(person.emailAddress)
              .foregroundStyle(.secondary)
          }
        }
      }
      TableColumn("Family Name", value: \.familyName)
      TableColumn("E-Mail Address", value: \.emailAddress)
    }
    .onChange(of: sortOrder) { _, sortOrder in
      people.sort(using: sortOrder)
    }
  }
}

#Preview {
    TableView()
}
