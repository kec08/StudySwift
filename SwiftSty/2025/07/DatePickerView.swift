//
//  DatePickerView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/10/25.
//

import SwiftUI

struct DatePickerView: View {
  @State private var date = Date()
  
  var body: some View {
    DatePicker(
      "Select Date",
      selection: $date,
      displayedComponents: [.date, .hourAndMinute]
    )
    .padding(.horizontal, 20)
  }
}

#Preview {
    DatePickerView()
}
