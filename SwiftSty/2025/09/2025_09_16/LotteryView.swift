//
//  LotteryView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/16/25.
//

import SwiftUI

struct LotteryView: View {
    @ObservedObject var lotteryViewModel = LotteryViewModel()
    @State private var inputLotteryDrwNo = ""
    
    var body: some View {
        VStack{
            TextField("Input DrwNo", text: $inputLotteryDrwNo)
            Text("\(lotteryViewModel.lotteryNum)")
                .font(.body)
                .foregroundColor(.yellow)
                .background(.green)
            Button {
                lotteryViewModel.getLotteryData(drwNo: inputLotteryDrwNo)
            } label: {
               Text("Click get Lottery")
            }


        }
        .padding()
    }
}

#Preview {
    LotteryView()
}
