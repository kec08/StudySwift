//
//  VideoPlayerView.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import AVKit

final public class VideoPlayerViewModel: ObservableObject {
  enum ContentType {
    case video, unknown
  }

  @Published var contentURL: String
  @Published var remainingRetries: Int

  var canPlay: Bool {
    filterByExtension(url: contentURL) == .video
  }

  public init(contentURL: String, remainingRetries: Int = 5) {
    self.contentURL = contentURL
    self.remainingRetries = remainingRetries
  }

  private func filterByExtension(url: String) -> ContentType {
    let videoExtensions = [
      "mp4", "mov", "m4v", "avi", "mpg", "mpeg", "3gp", "mkv", "webm", "flv", "m3u8"
    ]
    guard let ext = URL(string: url)?.pathExtension.lowercased() else { return .unknown }
    return videoExtensions.contains(ext) ? .video : .unknown
  }

  @MainActor
  func retryPlayVideo() async -> Bool {
    remainingRetries -= 1
    return remainingRetries > 0
  }
}


