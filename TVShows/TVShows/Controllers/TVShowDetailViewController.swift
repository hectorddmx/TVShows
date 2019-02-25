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
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var imdbButton: UIButton!
  @IBOutlet weak var summaryTextView: UITextView!
  @IBOutlet weak var ratingLabel: UILabel!
  
  // MARK: - Configuration
  
  override func prepareNavigationBar() {
    super.prepareNavigationBar()
  }
  
  @objc func toggleFavorite() {
    guard let tvShow = tvShow  else { return }
    tvShow.setFavoriteStatus(favorite: !tvShow.isFavorite)
    toggleFavoriteButton()
  }
  
  fileprivate func toggleFavoriteButton() {
    let style: UIBarButtonItem.SystemItem
    guard let tvShow = tvShow  else { return }
    if tvShow.isFavorite {
      style = .trash
    } else {
      style = .add
    }
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: style,
      target: self,
      action: #selector(toggleFavorite)
    )
  }
  
  private func prepareScreen(
    name: String,
    poster: String,
    summary: String,
    imdb: String,
    rating: Double,
    isFavorite: Bool,
    id: Int
    ) {
    navigationItem.title = name
    posterImageView.loadImage(fromURL: poster)
    imdbButton.isHidden = imdb.isEmpty
    imdbButton.setTitle("IMDb: \(imdb)", for: .normal)
    
    summaryTextView.attributedText = summary.htmlToAttributedString
    summaryTextView.scrollRangeToVisible(NSRange(location:0, length:0))
    ratingLabel.text = "Rating: \(rating)"
    
    toggleFavoriteButton()
  }
  
  // MARK: - Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    UIView.animate(withDuration: 0.3, animations: {
      self.navigationController?.navigationBar.barTintColor = UIColor(rgb: Colors.showDetailHeader.rawValue)
    })
    toggleFavoriteButton()
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
    guard let tvShow = tvShow else { return }
    prepareScreen(
      name: tvShow.name ?? "",
      poster: tvShow.image?.original ?? "",
      summary: tvShow.summary ?? "",
      imdb: tvShow.externals?.imdb ?? "",
      rating: tvShow.rating?.average ?? 0.0,
      isFavorite: tvShow.isFavorite,
      id: tvShow.id ?? 0
    )    
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    summaryTextView.setContentOffset(.zero, animated: true)
  }
  
  // MARK: - Navigation
  
  @IBAction func openIMDBAction(_ sender: UIButton) {
    guard
      let tvShow = tvShow,
      let imdb = tvShow.externals?.imdb,
      !imdb.isEmpty
      else {
        showGenericErrorMessage(message: "Oops, something went wrong")
        return
    }
    
    guard var baseURL: URL = URL(string: "https://www.imdb.com/title")
      else { return }
    
    baseURL.appendPathComponent(imdb)
    UIApplication.shared.open(baseURL, options: [:], completionHandler: nil)
  }
}
