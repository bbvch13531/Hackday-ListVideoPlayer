//
//  VideoPlayerView.swift
//  ListVideoPlayer
//
//  Created by KyungYoung Heo on 01/10/2019.
//  Copyright © 2019 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class VideoPlayerView: UIView {
  var player: AVPlayer? {
    get {
      return playerLayer.player
    }
    
    set {
      playerLayer.player = newValue
    }
  }
  
  override class var layerClass: AnyClass {
    return AVPlayerLayer.self
  }
  
  var playerLayer: AVPlayerLayer {
    return layer as! AVPlayerLayer
  }
}
