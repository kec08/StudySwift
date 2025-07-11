//
//  DatePickerCustomView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/10/25.
//

import SwiftUI

enum ColorSet: String, CaseIterable, Identifiable {
  case green
  case red
  case blue
  
  var backgroundColor: Color {
    switch self {
    case .green:
      return .green
    case .red:
      return .red
    case .blue:
      return .blue
    }
  }
  
  var id: Self { self }
}

struct PickerCustomView: View {
  @State private var selectedColor: ColorSet = .green
  
  var body: some View {
    VStack {
      Rectangle()
        .fill(selectedColor.backgroundColor)
        .frame(width: 200, height: 200)
      
      Picker(
        "Color",
        selection: $selectedColor
      ) {
        ForEach(ColorSet.allCases) { color in
          Text(color.rawValue.capitalized)
        }
      }
    }
  }
}

#Preview {
    PickerCustomView()
}
