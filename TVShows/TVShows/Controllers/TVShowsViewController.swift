//
//  TVShowsViewController.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

@IBDesignable
class TVShowsViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var showsTableView: UITableView!
  
  // MARK: - Properties
  
  enum ScreenType: String {
    case tvShows
    case favorites
    case undefined
  }
  @IBInspectable private var _screenType: String?
  public var screenType: ScreenType {
    guard let _screenType = _screenType else { return .undefined }
    return ScreenType.init(rawValue: _screenType) ?? .undefined
  }
  
  enum ScreenState {
    case empty
    case populated([TVShow])
    
    var currentTVShows: [TVShow] {
      switch self {
      case .empty: return []
      case .populated(let tvShows):
        return tvShows
      }
    }
  }
  public var screenState: ScreenState = ScreenState.empty {
    didSet {
      showsTableView.reloadData()
    }
  }
 
  // MARK: - Configuration
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private func prepareNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let title: String
    switch screenType {
    case .favorites: title = "Favorites"
    case .tvShows: title = "TV Shows"
    case .undefined: title = ""
    }
    navigationItem.title = title
  }
  
  private func prepareShowsTableView() {
    showsTableView.delegate = self
    showsTableView.dataSource = self
    
    let nib = UINib(nibName: TVShowTableViewCell.nibName, bundle: .main)
    showsTableView.register(
      nib,
      forHeaderFooterViewReuseIdentifier: TVShowTableViewCell.reuseIdentifier
    )
  }
  
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareNavigationBar()
    prepareShowsTableView()
  }
  
   // MARK: - Navigation
}

// MARK: - Delegates


extension TVShowsViewController: UITableViewDelegate {
  
}


extension TVShowsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return screenState.currentTVShows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let showCell: TVShowTableViewCell = tableView.dequeueReusableCell(
        withIdentifier: TVShowTableViewCell.reuseIdentifier,
        for: indexPath
      ) as? TVShowTableViewCell
      else { return UITableViewCell() }
    showCell.load(tvShow: screenState.currentTVShows[indexPath.row])
    return showCell
  }
  
}
