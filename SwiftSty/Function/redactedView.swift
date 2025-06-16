//
//  asfads.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/15/25.
//

import SwiftUI

// MARK: - 데이터 모델 정의
struct Developer: Hashable, Decodable {
  let name: String
  let description: String
  let followers: Int
}

extension Developer {
  static let mock = Developer(
    name: "김은찬",
    description: "안녕하세요 iOS Developer입니다",
    followers: 12312
  )
}

// MARK: - 메인 리스트 뷰
struct DeveloperListView: View {
  @State private var isLoading: Bool = true

  var body: some View {
    VStack(spacing: 20) {
      Text("개발자 프로필")
        .font(.title.bold())
        .padding(.top)

      // 기본 뷰
      DeveloperView(developer: .mock)

      Divider()

      // 로딩 중인 상태 (스켈레톤 UI)
      DeveloperView(developer: .mock)
        .redacted(reason: isLoading ? .placeholder : [])

      Divider()

      // 커스터마이징 redacted 적용 예시
      DeveloperReasonAdaptView(developer: .mock)
        .redacted(reason: isLoading ? [.placeholder, .images] : [])

      Spacer()
    }
    .padding()
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        isLoading = false
      }
    }
  }
}

// MARK: - 개발자 정보 뷰
private struct DeveloperView: View {
  let developer: Developer

  var body: some View {
    HStack(spacing: 20) {
      VStack {
        Image(systemName: "person.fill")
          .resizable()
          .frame(width: 50, height: 50)
        Text(String(developer.followers))
          .font(.title)
      }
      .foregroundColor(.green)

      VStack(alignment: .leading, spacing: 4) {
        Text(developer.name)
          .font(.headline)
          .unredacted() // 항상 이름은 노출
        Text(developer.description)
          .foregroundColor(.secondary)
      }
    }
  }
}

// MARK: - 커스터마이징 redacted를 반영한 뷰
private struct DeveloperReasonAdaptView: View {
  @Environment(\.redactionReasons) var reasons
  let developer: Developer

  var body: some View {
    HStack(spacing: 20) {
      VStack {
        Image(systemName: "person.fill")
          .resizable()
          .frame(width: 50, height: 50)
          .unredacted(when: !reasons.contains(.images))

        Text(String(developer.followers))
          .font(.title)
      }
      .foregroundColor(.green)

      VStack(alignment: .leading, spacing: 4) {
        Text(developer.name)
          .font(.headline)
        Text(developer.description)
          .foregroundColor(.secondary)
      }
    }
  }
}

// MARK: - 커스터마이징 redacted 관련 확장
extension RedactionReasons {
  static let text = RedactionReasons(rawValue: 1 << 2)
  static let images = RedactionReasons(rawValue: 1 << 4)
}

extension View {
  @ViewBuilder
  func unredacted(when condition: Bool) -> some View {
    if condition {
      self.unredacted()
    } else {
      self
    }
  }
}

// MARK: - 미리보기
struct DeveloperListView_Previews: PreviewProvider {
  static var previews: some View {
    DeveloperListView()
  }
}
