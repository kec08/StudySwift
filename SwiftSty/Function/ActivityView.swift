//
//  ContentView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/11/25.
//

import SwiftUI

public struct ActivityView: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  public let activityItmes: [Any]
  public let applicationActivities: [UIActivity]? = nil
  
  public func makeUIViewController(context: Context) -> UIViewController {
    UIViewController()
  }
  
  public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    let activityViewController = UIActivityViewController(
      activityItems: activityItmes,
      applicationActivities: applicationActivities
    )

    if isPresented && uiViewController.presentedViewController == nil {
      uiViewController.present(activityViewController, animated: true)
    }
    activityViewController.completionWithItemsHandler = { (_, _, _, _) in
      isPresented = false
    }
  }
}

struct Activity: View {
  @State private var isActivityViewPresented = false
  
  var body: some View {
    Button("공유하기") {
      self.isActivityViewPresented = true
    }
    .background(
      ActivityView(
        isPresented: $isActivityViewPresented,
        activityItmes: [URL(string: "https://github.com/kec08")!]
      )
    )
  }
}

#Preview {
    Activity()
}
