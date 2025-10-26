//
//  2025_10_26_ViewModelable.swift
//  SwiftSty
//
//  Created by 김은찬 on 10/26/25.
//

import SwiftUI
import Combine

protocol ViewModelable: ObservableObject {
  associatedtype Action
  associatedtype State
  
  var state: State { get }
  
  func action(_ action: Action)
}
