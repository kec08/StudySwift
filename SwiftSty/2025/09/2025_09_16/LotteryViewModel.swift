//
//  LotteryViewModel.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/16/25.
//

import Foundation
import Alamofire

class LotteryViewModel: ObservableObject {
    @Published var lotteryData: LotteryData? = nil
    @Published var lotteryNum: String = ""
    
    func getLotteryData(drwNo: String) {
        let url = "https://www.dhlottery.co.kr/common.do"
        
        guard let sessionUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }

        let param: [String: Any] = [
            "method" : "getLottoNumber",
            "drwNo" : drwNo
        ]
        
        AF.request(sessionUrl, method: .get, parameters: param, encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LotteryData.self) { response in
                switch response.result {
                case .success(let data) :
                    self.lotteryData = data
                    self.lotteryNum = "\(data.drwtNo1) \(data.drwtNo2) \(data.drwtNo3) \(data.drwtNo4) \(data.drwtNo5) \(data.drwtNo6)"
                    print(self.lotteryData ?? "nil data")
                case .failure(let error) :
                    print(error)
                }
            }
    }
    
}
