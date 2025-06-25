//
//  GreenVideoPlayerViewModel.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import AVKit
import Combine

final public class GreenVideoPlayerViewModel: ObservableObject {
  @Published var pipStatus: PipStatus = .unowned
  @Published var media: Media?

  let player = AVPlayer()
  private var cancellable: AnyCancellable?

  public init() {
    setAudioSessionCategory(to: .playback)
    cancellable = $media
      .compactMap({ $0 })
      .compactMap({ URL(string: $0.url) })
      .sink(receiveValue: { [weak self] in
        self?.player.replaceCurrentItem(with: AVPlayerItem(url: $0))
      })
  }

  func play() {
    player.play()
  }

  func pause() {
    player.pause()
  }

  func mute(_ isMuted: Bool) {
    player.isMuted = isMuted
  }

  func setAudioSessionCategory(to value: AVAudioSession.Category) {
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(value)
    } catch {
      print("Setting category failed.")
    }
  }
}

public struct Media {
  let url: String
}
