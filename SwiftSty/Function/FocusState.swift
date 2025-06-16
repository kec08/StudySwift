//
//  FocusState.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import SwiftUI

struct FocusState: View {
  @State var name: String = ""
  @State var password = ""
  @FocusState var focusField: Field?
  
  var body: some View {
    Form {
      TextField("Name", text: $name)
        .focused($focusField, equals: .name)
        .onSubmit {
          focusField = .password
        }
      TextField("Password", text: $password)
        .focused($focusField, equals: .password)
        .onSubmit {
          checkTextFiled()
        }
      Button("Login") {
        checkTextFiled()
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        focusField = .name
      }
    }
  }
  
  private func checkTextFiled() {
    if name.isEmpty {
      focusField = .name
    } else if password.isEmpty {
      focusField = .password
    } else {
      focusField = nil
      // 로그인 처리 로직 🙌
    }
  }
}

enum Field: Hashable {
  case name
  case password
}

#Preview {
    FocusState(name: "dd", password: "dd", focusField: 1231)
}
