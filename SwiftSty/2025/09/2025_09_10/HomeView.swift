//
//  HomeView.swift
//  SwiftSty
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var bigBanner: String = ""
    @State var dramas: [Drama] = []
    
    var body: some View {
        ScrollView {
            
            HStack {
                Image("Netfilx_Icon")
                    .resizable()
                    .frame(width: 35, height: 60)
                    .padding()
                
                Spacer()
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
            }
            
            AsyncImage(url: URL(string: bigBanner)) { image in
                image
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 525)
                
                
                
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .frame(width: 300, height: 525)
                    .opacity(0.4)
                    .overlay(
                        ProgressView()
                            .tint(Color.white)
                    )
            }
            .overlay(alignment: .bottom) {
                HStack {
                    Button(action: {
                        print("재생 버튼 클릭됨")
                    }, label: {
                        Image(systemName: "play.fill")
                    })
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        print("info 클릭됨")
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            
            if dramas.count == 0 {
                ProgressView()
                    .tint(Color.white)
                    .padding()
                    .task {
                        do {
                            let url = URL(string: "https://gvec03gvkf.execute-api.ap-northeast-2.amazonaws.com")!
                            let (data, _) = try await URLSession.shared.data(from: url)
                            
                            let decoder = JSONDecoder()
                            let dramaCollection = try decoder.decode(DramaCollection.self, from: data)
                            
                            bigBanner = dramaCollection.bigBanner
                            dramas = dramaCollection.dramas
                        } catch {
                            print("데이터 불러오기 실패: \(error.localizedDescription)")
                        }
                    }

            } else {
                Text("dramas 장착완료")
            }
            
        }
        .background(.black)
        .foregroundStyle(.white)
    }
}

#Preview {
    HomeView()
}
