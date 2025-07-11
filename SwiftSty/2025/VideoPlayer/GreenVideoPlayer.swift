//
//  GreenVideoPlayer.swift
//  SwiftSty
//
//  Created by 김은찬 on 6/25/25.
//

import AVKit
import SwiftUI

public struct GreenVideoPlayer: UIViewControllerRepresentable {
  @ObservedObject var viewModel: GreenVideoPlayerViewModel
  var isDisplayPlaybackControls: Bool
  var isRequireLinearPlayback: Bool
  var videoGravity: AVLayerVideoGravity
  var isAllowPIP: Bool
  var autorotate: Bool
  var interfaceMode: InterfaceOrientationMode
  var isAllowExternalPlayback: Bool

  public init(
    viewModel: GreenVideoPlayerViewModel,
    isDisplayPlaybackControls: Bool = true,
    isRequireLinearPlayback: Bool = false,
    videoGravity: AVLayerVideoGravity = .resizeAspect,
    isAllowPIP: Bool = true,
    autorotate: Bool = true,
    interfaceMode: InterfaceOrientationMode = .all,
    isAllowExternalPlayback: Bool = false
  ) {
    self.viewModel = viewModel
    self.isDisplayPlaybackControls = isDisplayPlaybackControls
    self.isRequireLinearPlayback = isRequireLinearPlayback
    self.videoGravity = videoGravity
    self.isAllowPIP = isAllowPIP
    self.autorotate = autorotate
    self.interfaceMode = interfaceMode
    self.isAllowExternalPlayback = isAllowExternalPlayback
  }

  public func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = CustomAVPlayerViewController(
      autorotate: autorotate,
      interfaceMode: interfaceMode
    )

    controller.player = viewModel.player
    controller.delegate = context.coordinator
    controller.showsPlaybackControls = isDisplayPlaybackControls
    controller.requiresLinearPlayback = isRequireLinearPlayback
    controller.videoGravity = videoGravity
    controller.allowsPictureInPicturePlayback = isAllowPIP
    controller.player?.allowsExternalPlayback = isAllowExternalPlayback

    return controller
  }

  public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    uiViewController.player = viewModel.player
    uiViewController.allowsPictureInPicturePlayback = isAllowPIP
  }

  public func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }

  public class Coordinator: NSObject, AVPlayerViewControllerDelegate {
    let parent: GreenVideoPlayer
    public init(_ parent: GreenVideoPlayer) {
      self.parent = parent
    }

    public func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .willStart
    }
    public func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .didStart
    }
    public func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .willStop
    }
    public func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
      parent.viewModel.pipStatus = .didStop
    }
  }
}

public enum InterfaceOrientationMode {
  case portrait
  case all
}

class CustomAVPlayerViewController: AVPlayerViewController {
  var autorotate: Bool
  var interfaceMode: InterfaceOrientationMode

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(autorotate: Bool = true, interfaceMode: InterfaceOrientationMode = .all) {
    self.autorotate = autorotate
    self.interfaceMode = interfaceMode
    super.init(nibName: nil, bundle: nil)
  }

  override var shouldAutorotate: Bool {
    return autorotate
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return interfaceMode == .portrait ? .portrait : .all
  }
}

public enum PipStatus: String {
  case willStart, didStart, willStop, didStop, unowned
}
