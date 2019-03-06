//
//  TVShowTableViewCell.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
  
  var task: URLSessionTask?
  
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
  
  override func prepareForReuse() {
    showTitleLabel.text = ""
    showThumbImageView.image = UIImage()
  }
  
  func load(tvShow: TVShow) {
    if let name = tvShow.name {
      showTitleLabel.text = name
    }
    
    if let image = tvShow.image,
      let mediumImage = image.medium {
      showThumbImageView.loadImage(fromURL: mediumImage)
    }
  }
  
  func load(tvShowStore: TVShowStore) {
    
    showTitleLabel.text = ""
    showThumbImageView.image = UIImage()
    
    if !tvShowStore.name.isEmpty {
      showTitleLabel.text = tvShowStore.name
    }
    
    if !tvShowStore.imageMedium.isEmpty {
      showThumbImageView.loadImage(fromURL: tvShowStore.imageMedium)
    }
  }
  
  func loadImage(forImageView imageView: UIImageView, fromURL url: String) {
    
    task?.cancel()
    
    guard let imageURL: URL = URL(string: url) else {
      return
    }
    
    let cache: URLCache =  URLCache.shared
    let request = URLRequest(url: imageURL)
    DispatchQueue.global(qos: .userInitiated).async {
      if
        let data: Data = cache.cachedResponse(for: request)?.data,
        let image: UIImage = UIImage(data: data) {
        print("Getting cached image: \(url)")
        DispatchQueue.main.async {
          imageView.transition(toImage: image)
        }
      } else {
        print("Requesting image: \(url)")
        
        self.task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
          if
            let data = data,
            let response: URLResponse = response,
            ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
            let image: UIImage = UIImage(data: data) {
            let cachedData: CachedURLResponse = CachedURLResponse(
              response: response,
              data: data
            )
            cache.storeCachedResponse(
              cachedData,
              for: request
            )
            DispatchQueue.main.async {
              imageView.transition(toImage: image)
            }
          }
        })
        self.task?.resume()
      }
    }
  }
  
  
}
