//
//  2025_09_21_CombineView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/21/25.
//

import SwiftUI
import Combine
import Alamofire

// 모델
struct CombineUser: Codable, Identifiable {
    let id: Int
    let name: String
}

// 네트워킹 매니저
class UserService {
    func fetchUsers() -> AnyPublisher<[CombineUser], AFError> {
        AF.request("https://jsonplaceholder.typicode.com/users")
            .publishDecodable(type: [CombineUser].self)
            .value() // 결과값만 뽑아냄
            .eraseToAnyPublisher()
    }
}

// 뷰모델
class UserViewModel: ObservableObject {
    @Published var users: [CombineUser] = []
    private var cancellables = Set<AnyCancellable>()
    private let service = UserService()
    
    func loadUsers() {
        service.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("네트워크 오류: \(error)")
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
}

// SwiftUI View
struct CombineView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
        .onAppear {
            viewModel.loadUsers()
        }
    }
}

#Preview {
    CombineView()
}

