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
    showThumbImageView.loadImage(fromURL: tvShow.image.medium)
    showTitleLabel.text = tvShow.name
  }  
}