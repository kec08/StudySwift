//
//  2025_07_27_ShareLink.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/27/25.
//

import SwiftUI

struct Photo: Transferable {
  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation(exporting: \.image)
  }
  
  public var image: Image
  public var caption: String
}

struct PhotoView: View {
  let photo: Photo
  
  
  var body: some View {
    photo.image
      .toolbar {
        ShareLink(
          item: photo,
          preview: SharePreview(
            photo.caption,
            image: photo.image
          )
        )
      }
  }
}


struct ShareLinkView: View {
  var body: some View {
    NavigationView {
      PhotoView(photo: .init(image: .init(systemName: "circle.fill"), caption: "kec"))
    }
      ShareLink(
            item: "https://blog.naver.com/ssilvv",
            subject: Text("ssilvv Blog"),
            message: Text("iOS Naver Blog")) {
              Image(systemName: "square.and.arrow.up")
          }
  }
}

#Preview {
    ShareLinkView()
}
