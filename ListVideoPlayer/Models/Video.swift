//
//  Video.swift
//  ListVideoPlayer
//
//  Created by KyungYoung Heo on 01/10/2019.
//  Copyright © 2019 KyungYoung Heo. All rights reserved.
//

import Foundation

class Video: NSObject {
  let url: URL
  let thumbURL: URL
  let title: String
  let subtitle: String
  
  init(url: URL, thumbURL: URL, title: String, subtitle: String){
    self.url = url
    self.thumbURL = thumbURL
    self.title = title
    self.subtitle = subtitle
    
    super.init()
  }
  
  class func allVideos() -> [Video] {
    var videos = [Video]()
    var urls = [URL]()
    var thumbURLs = [URL]()
    let names = ["test1", "test2", "test3", "test4", "test5", "test6"]
    let titles = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6"]
    let subtitles = ["test1", "test2", "test3", "test4", "test5", "test6"]
    
    for (idx, name) in names.enumerated() {
      let stringpath =  + titles[idx]
      guard let urlPath = URL(string: stringpath + ".mp4") else { return [Video]() }
//      let urlPath = URL(fileURLWithPath: stringpath + ".mp4")
//      let thumbString = "Thumbnails/" + titles[idx] + ".jpg"
//      let thumbnailPath = URL(fileURLWithPath: thumbString)
      let thumbString = Bundle.main.path(forResource: titles[idx], ofType: "jpg")!
      let thumbnailPath = URL(fileURLWithPath: thumbString)
      print("urlPaht = \(urlPath), thumbnailPath = \(thumbnailPath)")
      urls.append(urlPath)
      thumbURLs.append(thumbnailPath)
      
      let video = Video(url: urlPath, thumbURL: thumbnailPath, title: titles[idx], subtitle: subtitles[idx])
      videos.append(video)
    }
    
    return videos
  }
  
}
