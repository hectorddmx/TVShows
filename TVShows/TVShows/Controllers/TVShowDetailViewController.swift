//
//  TVShowDetailViewController.swift
//  TVShows
//
//  Created by Hector de Diego on 2/25/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

class TVShowDetailViewController: BaseViewController {
  
  var tvShow: TVShow?
  var tvShowStore: TVShowStore?
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var imdbButton: UIButton!
  @IBOutlet weak var summaryTextView: UITextView!
  @IBOutlet weak var ratingLabel: UILabel!
  
  var imdbID: String = ""
  
  // MARK: - Configuration
  
  override func prepareNavigationBar() {
    super.prepareNavigationBar()
  }
  
  private func prepareScreen(
    name: String,
    poster: String,
    summary: String,
    imdb: String,
    rating: Double
    ) {
    navigationItem.title = name
    posterImageView.loadImage(fromURL: poster)
    imdbID = imdb
    imdbButton.isHidden = imdbID.isEmpty
    imdbButton.setTitle("IMDb: \(imdb)", for: .normal)
    
    summaryTextView.attributedText = summary.htmlToAttributedString
    summaryTextView.scrollRangeToVisible(NSRange(location:0, length:0))
    ratingLabel.text = "Rating: \(rating)"
  }
  
  // MARK: - Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    UIView.animate(withDuration: 0.3, animations: {
      self.navigationController?.navigationBar.barTintColor = UIColor(rgb: Colors.showDetailHeader.rawValue)
    })
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.3, animations: {
      self.navigationController?.navigationBar.barTintColor = UIColor(rgb: Colors.showListingHeader.rawValue)
    })
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    prepareNavigationBar()
    if let tvShow = tvShow {
      prepareScreen(
        name: tvShow.name ?? "",
        poster: tvShow.image?.original ?? "",
        summary: tvShow.summary ?? "",
        imdb: tvShow.externals?.imdb ?? "",
        rating: tvShow.rating?.average ?? 0.0
      )
    } else if let tvShowStore = tvShowStore {
      prepareScreen(
        name: tvShowStore.name,
        poster: tvShowStore.imageOriginal,
        summary: tvShowStore.summary,
        imdb: tvShowStore.imbd,
        rating: tvShowStore.ratingAverage
      )
    }
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    summaryTextView.setContentOffset(.zero, animated: true)
  }
  
  // MARK: - Navigation
  
  @IBAction func openIMDBAction(_ sender: UIButton) {
    
    if imdbID.isEmpty {
      showGenericErrorMessage(message: "Oops, something went wrong")
      return
    }
    
    guard var baseURL: URL = URL(string: "https://www.imdb.com/title")
      else { return }
    
    baseURL.appendPathComponent(imdbID)
    UIApplication.shared.open(baseURL, options: [:], completionHandler: nil)
  }
}
