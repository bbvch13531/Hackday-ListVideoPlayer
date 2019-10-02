//
//  VideoLooperView.swift
//  ListVideoPlayer
//
//  Created by KyungYoung Heo on 01/10/2019.
//  Copyright © 2019 KyungYoung Heo. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPreviewView: UIView {
  let videos: [Video]
  let videoPlayerView = VideoPlayerView()
  
  @objc private let player = AVQueuePlayer()
  private var token: NSKeyValueObservation?

  init(videos: [Video]) {
    self.videos = videos
    
    super.init(frame: .zero)
    
    initializePlayer()
    addGestureRecognizers()
  }
  
  private func initializePlayer() {
    videoPlayerView.player = player
    
    addAllVideosToPlayer()

    player.volume = 0.0
    player.play()
    
    token = player.observe(\.currentItem) { [weak self] player, _ in
      if player.items().count == 1 {
        self?.addAllVideosToPlayer()
      }
    }
  }
  
  private func addAllVideosToPlayer() {
    for video in videos {
      let asset = AVURLAsset(url: video.url)
      let item = AVPlayerItem(asset: asset)
      player.insert(item, after: player.items().last)
    }
  }
  
  func pause() {
    player.pause()
  }

  func play() {
    player.play()
  }
  
  // MARK - Gestures
  
  func addGestureRecognizers() {
  
    let tap = UITapGestureRecognizer(target: self, action: #selector(VideoPreviewView.wasTapped))
    let doubleTap = UITapGestureRecognizer(target: self,
                                           action: #selector(VideoPreviewView.wasDoubleTapped))
    doubleTap.numberOfTapsRequired = 2
  
    tap.require(toFail: doubleTap)

    addGestureRecognizer(tap)
    addGestureRecognizer(doubleTap)
  }
  
  @objc func wasTapped() {
    player.volume = player.volume == 1.0 ? 0.0 : 1.0
  }
  
  @objc func wasDoubleTapped() {
    player.rate = player.rate == 1.0 ? 2.0 : 1.0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
