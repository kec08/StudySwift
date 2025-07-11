//
//  ContentView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import SwiftUI

struct VideoView: View {
    var body: some View {
        VideoPlayerView(
            viewModel: VideoPlayerViewModel(
                contentURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
            )
        )
    }
}

#Preview {
    VideoView()
}
