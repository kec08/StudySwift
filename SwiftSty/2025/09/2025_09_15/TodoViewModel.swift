//
//  2025_09_15_TodoViewModel.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/15/25.
//

import Foundation
import Alamofire

class TodoViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    
    init() {
        fetchTodos()
    }
    
    func fetchTodos() {
        let url = "https://jsonplaceholder.typicode.com/todos"
        AF.request(url, method: .get)
            .responseDecodable(of: [Todo].self) { response in
                switch response.result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.todos = data
                    }
                case .failure(let error):
                    print("❌ FetchTodos Error: \(error)")
                }
            }
    }
    
    func postPost() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        let param: [String: Any] = [
            "userId": 1000,
            "id": 1000,
            "title": "title",
            "body": "body"
        ]
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
            .responseDecodable(of: TestPost.self) { response in
                switch response.result {
                case .success(let post):
                    print("✅ POST Success: \(post)")
                case .failure(let error):
                    print("❌ POST Error: \(error)")
                }
            }
    }
}

