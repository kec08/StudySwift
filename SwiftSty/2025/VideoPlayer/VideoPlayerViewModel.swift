//
//  VideoPlayerViewModel.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import SwiftUI

public struct VideoPlayerView: View {
  @StateObject var viewModel: VideoPlayerViewModel
  @StateObject private var greenVideoPlayerViewModel = GreenVideoPlayerViewModel()

  public var body: some View {
    GreenVideoPlayer(viewModel: greenVideoPlayerViewModel)
      .onAppear {
        greenVideoPlayerViewModel.media = Media(url: viewModel.contentURL)
      }
      .overlay(
        RetryView(
          title: "This video file could not be played",
          remainingRetries: viewModel.remainingRetries,
          perform: {
            Task {
              let canRetry = await viewModel.retryPlayVideo()
              if canRetry {
                greenVideoPlayerViewModel.play()
              }
            }
          }
        )
        .opacity(viewModel.canPlay ? 0 : 1)
      )
  }
}

private struct RetryView: View {
  var title: String
  var remainingRetries: Int
  var perform: () -> Void

  var body: some View {
    VStack(spacing: 10) {
      Spacer()
      Text(title).foregroundColor(.white)
      Button(
        action: remainingRetries > 0 ? perform : {},
        label: {
          Text(remainingRetries > 0 ? "Please try again" : "Please try again later")
        }
      )
      .padding()
      .background(remainingRetries > 0 ? Color.blue : Color.red)
      .foregroundColor(.white)
      .cornerRadius(10)
      .disabled(remainingRetries == 0)
      .padding(.bottom, 300)
    }
  }
}

