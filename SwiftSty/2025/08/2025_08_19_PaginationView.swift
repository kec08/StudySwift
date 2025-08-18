//
//  2025_08_19_PaginationView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/19/25.
//

import SwiftUI

// MARK: - 모델
struct Post {
  let title: String
  let description: String
}

struct PaginationPostData {
  let page: Int
  let isLast: Bool
  let posts: [Post]
}

extension PaginationPostData {
  static let stub1: PaginationPostData = .init(
    page: 1,
    isLast: false,
    posts: [
      .init(title: "1번 타이틀", description: "1번 설명"),
      .init(title: "2번 타이틀", description: "2번 설명"),
      .init(title: "3번 타이틀", description: "3번 설명"),
      .init(title: "4번 타이틀", description: "4번 설명"),
      .init(title: "5번 타이틀", description: "5번 설명"),
      .init(title: "6번 타이틀", description: "6번 설명"),
      .init(title: "7번 타이틀", description: "7번 설명"),
      .init(title: "8번 타이틀", description: "8번 설명"),
      .init(title: "9번 타이틀", description: "9번 설명"),
      .init(title: "10번 타이틀", description: "10번 설명")
    ]
  )
  
  static let stub2: PaginationPostData = .init(
    page: 2,
    isLast: true,
    posts: [
      .init(title: "11번 타이틀", description: "11번 설명"),
      .init(title: "12번 타이틀", description: "12번 설명"),
      .init(title: "13번 타이틀", description: "13번 설명"),
      .init(title: "14번 타이틀", description: "14번 설명"),
      .init(title: "15번 타이틀", description: "15번 설명"),
      .init(title: "16번 타이틀", description: "16번 설명"),
      .init(title: "17번 타이틀", description: "17번 설명")
    ]
  )
  
  static func getPosts(page: Int) -> PaginationPostData {
    if page == 1 {
      return PaginationPostData.stub1
    }
    return PaginationPostData.stub2
  }
}


// MARK: - 뷰모델
class ContentViewModel: ObservableObject {
  @Published var posts: [Post] = []
  var postsCount: Int {
    posts.count
  }
  var currentPage: Int = 1
  var isLastPage: Bool = false
  var isLoading: Bool = false
  
  @MainActor
  func getPosts() async {
    guard !isLoading, !isLastPage else { return }
    
    isLoading = true
    
    let postData = PaginationPostData.getPosts(page: currentPage)
    
    if currentPage == 1 {
      self.posts = postData.posts
    } else {
      self.posts.append(contentsOf: postData.posts)
    }
    
    isLastPage = postData.isLast
    currentPage += 1
    
    isLoading = false
  }
}


// MARK: - 뷰
struct PaginationView: View {
  @StateObject var viewModel: ContentViewModel = .init()
  
  var body: some View {
    VStack(spacing: 10) {
      Text("Post's count: \(viewModel.postsCount)")
        .font(.largeTitle)
      
      ScrollView {
        LazyVStack(spacing: 20) {
          ForEach(0..<(viewModel.posts.count), id: \.self) { index in
            HStack(spacing: 0) {
              VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.posts[index].title)
                  .font(.headline)
                  .foregroundColor(.primary)
                  .padding()
                  .background(Color.gray.opacity(0.1))
                  .cornerRadius(10)
                
                Text(viewModel.posts[index].description)
                  .font(.body)
                  .foregroundColor(.secondary)
                
                Rectangle()
                  .fill(.gray)
                  .frame(height: 1)
                  .padding(.horizontal, 5)
              }
              
              Spacer()
            }
            .onAppear {
              guard index == viewModel.posts.count - 1 else {
                return
              }
              
              Task {
                await viewModel.getPosts()
              }
            }
          }
        }
      }
    }
    .padding()
    .onAppear {
      Task {
        await viewModel.getPosts()
      }
    }
  }
}

#Preview {
    PaginationView()
}
