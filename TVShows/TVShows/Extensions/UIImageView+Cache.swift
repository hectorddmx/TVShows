//
//  UIImageView+Cache.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

/// UIImageView+Cache
public extension UIImageView {
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
          self.transition(toImage: image)
        }
      } else {
        print("Requesting image: \(url)")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
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
              self.transition(toImage: image)
            }
          }
        }).resume()
      }
    }
  }
  
  public func transition(toImage image: UIImage?) {
    UIView.transition(
      with: self, duration: 0.3,
      options: [.transitionCrossDissolve],
      animations: { self.image = image },
      completion: nil
    )
  }
}

