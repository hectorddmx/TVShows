//
//  TVShowsFavoritesViewController.swift
//  TVShows
//
//  Created by Hector de Diego on 2/24/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//


import UIKit

@IBDesignable
class TVShowsFavoritesViewController: BaseViewController {
  
  var favorites: [TVShowStore] = []
  
  // MARK: - Outlets
  @IBOutlet weak var showsTableView: UITableView!
  
  // MARK: - Properties
  
  func loadShows() {
    favorites = TVShowStore.getSavedShows()
    showsTableView.reloadData()
  }
  
  // MARK: - Configuration
  
  override func prepareNavigationBar() {
    super.prepareNavigationBar()
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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadShows()
  }

  // MARK: - Navigation
}

// MARK: - Delegates

extension TVShowsFavoritesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  fileprivate func removeFavorite(tableView: UITableView, indexPath: IndexPath) {
    self.favorites[indexPath.row].deleteFavorite()
    self.favorites.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let unfavoriteAction = UITableViewRowAction(
      style: .normal,
      title: "Delete"
    ) {
      [weak self] (rowAction, indexPath) in
      guard let self = self else { return }
      self.showActionAlert(vc: self) { [weak self] _ in
        guard let self = self else { return }
        self.removeFavorite(tableView: tableView, indexPath: indexPath)
      }
    }
    unfavoriteAction.backgroundColor = UIColor(rgb: 0xFF3A30)
    return [unfavoriteAction]
  }
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
    showCell.load(tvShowStore: favorites[indexPath.row])
    return showCell
  }
  
}
