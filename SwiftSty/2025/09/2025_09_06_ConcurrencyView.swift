//
//  2025_09_06_ConcurrencyView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/6/25.
//

import SwiftUI


struct MyStruct  {
    var myResult: Date {
        get async {
            return await self.getTime()
        }
    }
    
    func getTime() async -> Date {
        sleep(5)
        return Date()
    }
}

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
    
    var myResult: Date {
        get async {
            return await self.getTime()
        }
    }
    
    func getTime() async -> Date {
        sleep(5)
        return Date()
    }
    
    func doSomething() async {
        
        let myStruct = MyStruct()
        
        Task {
            let date = await myStruct.myResult
            
        }
    }
    
    
    func takesTooLong() async -> Date {
        sleep(5)
        return Date()
    }
    
}

#Preview {
    ConcurrencyView()
}
