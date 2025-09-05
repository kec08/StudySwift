//
//  2025_09_06_ConcurrencyView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/6/25.
//

import SwiftUI

struct ConcurrencyView: View {
    var body: some View {
        Button(action: {
            Task {
                await doSomething()
            }
        }) {
            Text("Do Something")
        }
    }
    
    func doSomething() async {
        print("Start \(Date())")
        async let result = takesTooLong()
        print("After async-let \(Date())")
        //TODO
        print("result = \(await result)")
        print("End \(Date())")
    }
    
    func takesTooLong() async -> Date {
        sleep(5)
        return Date()
    }
    
}

#Preview {
    ConcurrencyView()
}
