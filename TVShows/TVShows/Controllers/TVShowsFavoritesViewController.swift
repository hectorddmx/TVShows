//
//  TVShowsFavoritesViewController.swift
//  TVShows
//
//  Created by Hector de Diego on 2/24/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//


import UIKit

@IBDesignable
class TVShowsFavoritesViewController: UIViewController {
  
  var favorites: [TVShow] = []
  
  // MARK: - Outlets
  @IBOutlet weak var showsTableView: UITableView!
  
  // MARK: - Properties
  
  func loadShows() {
   
  }
  
  // MARK: - Configuration
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private func prepareNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Favorites"
  }
  
  private func prepareShowsTableView() {
    showsTableView.delegate = self
    showsTableView.dataSource = self
    
    let nib = UINib(nibName: TVShowTableViewCell.nibName, bundle: .main)
    showsTableView.register(nib, forCellReuseIdentifier: TVShowTableViewCell.reuseIdentifier)
  }
  
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareNavigationBar()
    prepareShowsTableView()
    loadShows()
  }
  
  // MARK: - Navigation
}

// MARK: - Delegates


extension TVShowsFavoritesViewController: UITableViewDelegate {
  
}


extension TVShowsFavoritesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let showCell: TVShowTableViewCell = tableView.dequeueReusableCell(
        withIdentifier: TVShowTableViewCell.reuseIdentifier,
        for: indexPath
        ) as? TVShowTableViewCell
      else { return UITableViewCell() }
    showCell.load(tvShow: favorites[indexPath.row])
    return showCell
  }
  
}
