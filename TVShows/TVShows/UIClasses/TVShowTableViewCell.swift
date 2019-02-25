//
//  TVShowTableViewCell.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: TVShowTableViewCell.self)
  static let nibName = String(describing: TVShowTableViewCell.self)
  
  @IBOutlet weak var showThumbImageView: UIImageView!
  @IBOutlet weak var showTitleLabel: UILabel!  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func load(tvShow: TVShow) {
    
    showTitleLabel.text = ""
    showThumbImageView.image = UIImage()
    
    if let name = tvShow.name {
      showTitleLabel.text = name
    }
    
    if let image = tvShow.image,
      let mediumImage = image.medium {
      showThumbImageView.loadImage(fromURL: mediumImage )
    }
  }
  
  func load(tvShowStore: TVShowStore) {
    
    showTitleLabel.text = ""
    showThumbImageView.image = UIImage()
    
    if !tvShowStore.name.isEmpty {
      showTitleLabel.text = tvShowStore.name
    }
    
    if !tvShowStore.imageMedium.isEmpty {
      showThumbImageView.loadImage(fromURL: tvShowStore.imageMedium )
    }
  }
}
