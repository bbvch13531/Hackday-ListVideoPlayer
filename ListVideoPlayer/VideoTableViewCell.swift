//
//  VideoTableViewCell.swift
//  ListVideoPlayer
//
//  Created by KyungYoung Heo on 01/10/2019.
//  Copyright © 2019 KyungYoung Heo. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
  let titleLabel = UILabel()
  let playerImageView = UIImageView()
  let subtitleLabel = UILabel()

  var video: Video? = nil {
    didSet {
      updateViews()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    backgroundColor = .blue
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(false, animated: false)
  }
  
  class func height(for viewModel: Video) -> CGFloat {
    let height: CGFloat = 200
    let padding: CGFloat = 16

    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24.0)
    label.text = viewModel.title
    let titleHeight = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 32, height: .infinity)).height
    
    label.text = viewModel.subtitle
    label.font = UIFont.systemFont(ofSize: 14.0)
    let subtitleHeight = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 32, height: .infinity)).height
    
    return padding + titleHeight + padding + height + padding + subtitleHeight + padding
  }
}

extension VideoTableViewCell {
  func addSubviews() {
    playerImageView.contentMode = .scaleAspectFill
    playerImageView.clipsToBounds = true
    playerImageView.layer.cornerRadius = 4.0
    
    addSubview(titleLabel)
    addSubview(playerImageView)
    addSubview(subtitleLabel)
  }
  
  func updateViews() {
    titleLabel.text = video?.title
    titleLabel.font = UIFont.systemFont(ofSize: 24.0)
    
    let image = UIImage(named: (video?.thumbURL.path)!)
    playerImageView.image = image
    
    subtitleLabel.text = video?.subtitle
    subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
    subtitleLabel.numberOfLines = 0
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let previewHeight: CGFloat = 200
    let padding: CGFloat = 16
    
    let widthWithPadding = bounds.width - (2*padding)
    
    // Size
    let titleSize = titleLabel.sizeThatFits(CGSize(width: widthWithPadding, height: .infinity))
    titleLabel.bounds = CGRect(x: 0, y: 0, width: titleSize.width, height: titleSize.height)
    
    let subtitleSize = subtitleLabel.sizeThatFits(CGSize(width: widthWithPadding, height: .infinity))
    subtitleLabel.bounds = CGRect(x: 0, y: 0, width: subtitleSize.width, height: subtitleSize.height)
    
    playerImageView.bounds = CGRect(x: 0, y: 0, width: widthWithPadding, height: previewHeight)
    
    // Center
    titleLabel.center = CGPoint(x: titleLabel.bounds.width/2.0 + padding, y: padding + titleLabel.bounds.height/2.0)
    
    let imageYCenter = titleLabel.frame.origin.y + titleSize.height + padding + previewHeight/2.0
    playerImageView.center = CGPoint(x: bounds.width/2.0, y: imageYCenter)
    
    let subtitleYCenter = playerImageView.frame.origin.y + playerImageView.bounds.height + padding
    subtitleLabel.center = CGPoint(x: subtitleLabel.bounds.width/2.0 + padding, y: subtitleYCenter)
  }
}
