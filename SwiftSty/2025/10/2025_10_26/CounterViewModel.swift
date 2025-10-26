//
//  CounterViewModel.swift
//  MVVMStudy
//
//  Created by 김은찬 on 10/26/25.
//

import SwiftUI
import Combine

final class CounterViewModel: ViewModelable {
  // MARK: Types
  enum Action {
    case onTapAddButton
    case onTapSubtractButton
  }
  enum State {
    case count(Int)
  }
  
  // MARK: Properties
  @Published var state: State
  
  // MARK: Initailizer
  init() {
    state = .count(0)
  }
  
  // MARK: Action
  func action(_ action: Action) {
    switch action {
    case .onTapAddButton:
      state = .count(getCurrnetCount() + 1)
    case .onTapSubtractButton:
      state = .count(getCurrnetCount() - 1)
    }
  }
  
  private func getCurrnetCount() -> Int {
    guard case let .count(int) = state else { return 0 }
    return int
  }
}

