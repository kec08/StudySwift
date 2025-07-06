//
//  StickyView.swift
//  SwiftSty
//
//  Created by 김은찬 on 7/7/25.
//

import SwiftUI

struct StickyView: View {
  @State var selectedTab: String = "First"
  
  var body: some View {
    VStack {
      Text("Sticky View")
        .font(.title)
        .bold()
      
      ScrollView {
        TopView()
        
        LazyVStack(
          spacing: 10,
          pinnedViews: .sectionHeaders
        ) {
          Section(header: StickHeaderView(selectedTab: $selectedTab)) {
            switch selectedTab {
            case "First":
              ItemsView(color: .blue)
              
            case "Second":
              ItemsView(color: .yellow)
              
            default:
              ItemsView(color: .green, count: 2)
            }
            Spacer()
          }
        }
      }
    }
  }
}

// MARK: - 탑 타이틀 뷰
struct TopView: View {
  var body: some View {
    HStack {
      Spacer()
      
      Text("Here is Top")
        .font(.title)
        .bold()
      
      Spacer()
    }
    .background(Color.green.opacity(0.5))
    .frame(height: 50)
  }
}

// MARK: - 고정될 헤더 뷰
struct StickHeaderView: View {
  @Binding var selectedTab: String
  
  var body: some View {
    HStack {
      Spacer()
      
      Button(
        action: {
          selectedTab = "First"
        },
        label: {
          Text("First")
            .font(.title)
            .bold()
            .foregroundColor(selectedTab == "First" ? .black : .gray)
        }
      )
      
      Button(
        action: {
          selectedTab = "Second"
        },
        label: {
          Text("Second")
            .font(.title)
            .bold()
            .foregroundColor(selectedTab == "Second" ? .black : .gray)
        }
      )
      
      Button(
        action: {
          selectedTab = "Third"
        },
        label: {
          Text("Third")
            .font(.title)
            .bold()
            .foregroundColor(selectedTab == "Third" ? .black : .gray)
        }
      )
      
      Spacer()
    }
    .background(.white)
  }
}

// MARK: - 컨텐츠로 담길 아이템 뷰
struct ItemsView: View {
  let color: Color
  let count: Int
  
  init(color: Color, count: Int = 20) {
    self.color = color
    self.count = count
  }
  
  var body: some View {
    VStack {
      ForEach(0...count, id: \.self) { _ in
        Rectangle()
          .fill(color)
          .cornerRadius(10)
          .frame(height:100)
      }
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
    StickyView()
}
