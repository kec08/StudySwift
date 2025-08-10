//
//  2025_08_11_ScrollPositionView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/11/25.
//

import SwiftUI

struct MyItem: Identifiable {
  let id: UUID
  let name: Int
}

struct ScrollPositionView: View {
  @State var items: [MyItem] = (1...100).map { num in
    MyItem(id: UUID(), name: num)
  }
  @State private var position: ScrollPosition = .init(idType: MyItem.ID.self)
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVStack {
          ForEach(items) { item in
            ItemView(item: item)
          }
        }
      }
      .scrollPosition($position)
     
      Button(
        action: {
          if let firstItemID = items.first?.id {
            position.scrollTo(id: firstItemID)
          }
        },
        label: {
          Text("Click")
        }
      )
    }
  }
}

struct ItemView: View {
  let item: MyItem
  
  var body: some View {
    HStack {
      Spacer()
      
      Text("\(item.name)")
      
      Spacer()
    }
    .frame(height: 50)
    .background(Color.green)
  }
}

#Preview {
    ScrollPositionView()
}
