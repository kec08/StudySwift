//
//  LoadingView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/22/25.
//

import SwiftUI
import UIKit

public class LoadingWindowView: UIWindow {
  public static let shared = LoadingWindow(frame: UIScreen.main.bounds)

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented: please use LoadingWindow.shared")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let loadingViewController = UIHostingController(rootView: LoadingView())
    loadingViewController.view?.backgroundColor = .clear
    self.rootViewController = loadingViewController
    self.isHidden = true
  }

  func show() {
    self.isHidden = false
  }

  func hide() {
    self.isHidden = true
  }

  func toggle() {
    if self.isHidden {
      show()
    } else {
      hide()
    }
  }
}

#Preview{
    LoadingWindowView()
}
