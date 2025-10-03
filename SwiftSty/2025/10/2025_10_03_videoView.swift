//
//  2025_10_03_VideoPlayerView.swift
//  SwiftSty
//
//  Created by 김은찬 on 10/3/25.
//

import AVKit
import SwiftUI

struct videoView: View {
    private let player = AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    
    var body: some View {
        VideoPlayer(player: player)
            .overlay(
                VStack {
                    Text("서근개발블로그")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(6)
                        .padding()
                    Spacer()
                },
                alignment: .topLeading
            )
            .onAppear {
                player.play()
            }
    }
}


