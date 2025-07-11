//
//  OutlineGroupView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/16/25.
//

import SwiftUI

struct FileItem: Hashable, Identifiable, CustomStringConvertible {
  var id: Self { self }
  var name: String
  var children: [FileItem]? = nil
  var description: String {
    switch children {
    case nil:
      return "📄 \(name)"
    case .some(let children):
      return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
    }
  }
}

struct OutlineGroupView: View {
  let data =
  FileItem(
    name: "ssilvv",
    children: [
      FileItem(
        name: "kec",
        children: [
          FileItem(
            name: "Posting",
            children:  [
              FileItem(
                name: "SwiftUI.jpg"),
              FileItem(name: "Swift.jpg")]),
          FileItem(
            name: "Simulator",
            children: [
              FileItem(name: "music.mp4")]),
          FileItem(name: "Etc", children: [])
        ]),
      FileItem(
        name: "study",
        children: [
          FileItem(name: "SwiftUI", children: [])
        ])
    ])
  
  var body: some View {
    OutlineGroup(data, children: \.children) { item in
      Text("\(item.description)")
    }
  }
}

#Preview {
    OutlineGroupView()
}
