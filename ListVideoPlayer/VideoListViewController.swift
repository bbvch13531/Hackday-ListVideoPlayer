//
//  VideoListViewController.swift
//  ListVideoPlayer
//
//  Created by KyungYoung Heo on 01/10/2019.
//  Copyright © 2019 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class VideoListViewController: UIViewController {
  var videos = [Video]()
  
  let videoCellReuseIdentifier = "VideoCell"
  let tableView = UITableView()
  
  let videoPreviewPlayer = VideoPreviewView(videos: Video.allVideos())
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    videoPreviewPlayer.play()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    videoPreviewPlayer.pause()
  }
}

extension VideoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let video = videos[indexPath.row]
    return VideoTableViewCell.height(for: video)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let video = videos[indexPath.row]
    
    let videoURL = video.url
    let player = AVPlayer(url: videoURL)
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    
    present(playerViewController, animated: true){
      player.play()
    }
  }
}

extension VideoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return videos.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: videoCellReuseIdentifier, for: indexPath) as? VideoTableViewCell else {
      return VideoTableViewCell()
    }
    cell.video = videos[indexPath.row]
    return cell
  }
}

extension VideoListViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadViews()
  }
  
  func loadViews() {
    view.backgroundColor = .white
    
    tableView.register(VideoTableViewCell.classForCoder(), forCellReuseIdentifier: videoCellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    view.addSubview(videoPreviewPlayer)
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    tableView.frame = view.bounds
    
    videoPreviewPlayer.frame = CGRect(x: view.bounds.width - 150 - 16, y: view.bounds.height - 100 - 16, width: 150, height: 100)
    videoPreviewPlayer.backgroundColor = .black
  }
}
