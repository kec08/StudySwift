//
//  2025_07_20_ BorderlessButtonStyleView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/20/25.
//
import SwiftUI

struct BorderlessButtonStyleView: View {
  @State var title: String = ""
  var colors: [Color] = [.orange, .red, .blue, .black, .brown]
  
  var body: some View {
    VStack {
      Text(title)
        .font(.title)
        .bold()
      
      List {
        ForEach(colors, id: \.self) { color in
          CellView(title: $title, color: color)
            .onTapGesture {
              title = "\(color.description) Cell Tapped"
            }
        }
      }
      .listStyle(.plain)
    }
  }
}

private struct CellView: View {
  @Binding var title: String
  var color: Color
  
  var body: some View {
    VStack {
      RoundedRectangle(cornerRadius: 10)
        .fill(color)
        .frame(width: 100, height: 100)
      
      Button(
        action: {
          title = "Button Clicked"
        },
        label: {
          Text("Click Button")
        }
      )
    //이벤트 버블링 해결방안 2
      .buttonStyle(.borderless)
        
        //이벤트 버블링 해결방안 1
//        Text("Click Button")
//            .onTapGesture {
//                  title = "Button Clicked"
//            }

      Spacer()
    }
  }
}

#Preview{
    BorderlessButtonStyleView()
}
