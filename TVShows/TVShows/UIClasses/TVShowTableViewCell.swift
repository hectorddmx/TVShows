//
//  TVShowTableViewCell.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
  
  var task: URLSessionTask? // 1. The task that needs to be canceled when reusing the cell
  
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

    self.task?.cancel() // 2. The task should be canceled before anything else is configured in my cell
    // Canceling the task will avoid the image from continue downloading and being loaded some seconds later....

    if let name = tvShow.name {
      showTitleLabel.text = name
    }

    if let image = tvShow.image,
      let mediumImage = image.medium {
      loadImage(fromURL: mediumImage) // 3. The image will be downloaded if we have a URL string...
    }
  }

  // The function that loads my image in my imageView
  // If there is a cached version, it will load that
  // If not, it will download that and cache it.
  func load(tvShowStore: TVShowStore) {

    self.task?.cancel()

    showTitleLabel.text = ""
    showThumbImageView.image = UIImage()

    if !tvShowStore.name.isEmpty {
      showTitleLabel.text = tvShowStore.name
    }

    if !tvShowStore.imageMedium.isEmpty {
      loadImage(fromURL: tvShowStore.imageMedium)
    }
  }

  public func loadImage(fromURL url: String) {

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
          self.showThumbImageView.transition(toImage: image)
        }

      } else {
        print("Requesting image: \(url)")
        // 4. We need to set the task to be the current download, we do this by assigning the dataTask to this variable
        self.task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
          if let data = data,
            let response: URLResponse = response,
            ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
            let image: UIImage = UIImage(data: data) {

            let cachedData: CachedURLResponse = CachedURLResponse( response: response, data: data)
            cache.storeCachedResponse(cachedData, for: request)
            DispatchQueue.main.async {
              self.showThumbImageView.transition(toImage: image)
            }
          }
        }) // 5. Instead of calling here resume() directly, we have to do that now in the variable
        self.task?.resume() // 6. We call resume() so the download is sent.
      }
    }
  }
  

  


}
