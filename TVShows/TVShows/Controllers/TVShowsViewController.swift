//
//  TVShowsViewController.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

class TVShowsViewController: BaseViewController {
  
  let networkingService = NetworkingService()
  
  // MARK: - Outlets
  @IBOutlet weak var showsTableView: UITableView!
  
  // MARK: - Properties
  enum ScreenState {
    case empty
    case loading
    case error(Error)
    case populated([TVShow])
  }
  var currentTVShows: [TVShow] = []
  var tvShow: TVShow?

  public var screenState: ScreenState = ScreenState.empty {
    didSet {
      switch screenState {
      case .populated(let tvShows):
        currentTVShows = tvShows
      case .error(let error):
        handleErrorMessage(vc: self, error: error) {
          [weak self] _ in
          guard let self = self else { return }
          self.loadShows()
        }
        fallthrough
      default:
        currentTVShows = []
      }
      showsTableView.reloadData()
    }
  }
  
  func loadShows() {
    networkingService.fetchTVShows() { [weak self] response in
      guard let self = self else { return }
      self.update(response: response)
    }
  }
  
  func update(response: TVShowsModel) {
    if let error = response.error {
      screenState = .error(error)
      return
    }
    
    guard let tvShows = response.tvShows, !tvShows.isEmpty else {
      screenState = .empty
      return
    }
    
    screenState = .populated(tvShows)
  }
  
  // MARK: - Configuration

  override func prepareNavigationBar() {
    super.prepareNavigationBar()
    navigationItem.title = "TV Shows"
  }
  
  private func prepareShowsTableView() {
    showsTableView.delegate = self
    showsTableView.dataSource = self
    
    let nib = UINib(nibName: TVShowTableViewCell.nibName, bundle: .main)
    showsTableView.register(nib, forCellReuseIdentifier: TVShowTableViewCell.reuseIdentifier)
    showsTableView.register(
      nib,
      forCellReuseIdentifier: TVShowTableViewCell.reuseIdentifier
    )
  }
  
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareNavigationBar()
    prepareShowsTableView()
    loadShows()
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if
      segue.identifier == Segues.tvShowDetailSegue.rawValue,
      let destination = segue.destination as? TVShowDetailViewController {
      destination.tvShow = tvShow
    }
  }
}

// MARK: - Delegates


extension TVShowsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tvShow = currentTVShows[indexPath.row]
    performSegue(withIdentifier: Segues.tvShowDetailSegue.rawValue, sender: self)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
  }
  
  fileprivate func buildUnfavoriteAction() -> [UITableViewRowAction]? {
    let unfavoriteAction = UITableViewRowAction(
    style: .normal, title: "Delete") { [weak self] (rowAction, indexPath) in
      guard let self = self else { return }
      self.showActionAlert(vc: self) { [weak self] _ in
        guard let self = self else { return }
        self.currentTVShows[indexPath.row].setFavoriteStatus(favorite: false)
      }
    }
    unfavoriteAction.backgroundColor = UIColor(rgb: Colors.unfavorite.rawValue)
    return [unfavoriteAction]
  }
  
  fileprivate func buildFavoriteAction() -> [UITableViewRowAction]? {
    let favoriteAction = UITableViewRowAction(
    style: .normal, title: "Favorite") { [weak self] (rowAction, indexPath) in
      guard let self = self else { return }
      self.currentTVShows[indexPath.row].setFavoriteStatus(favorite: true)
    }
    favoriteAction.backgroundColor = UIColor(rgb: Colors.favorite.rawValue)
    return [favoriteAction]
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    if currentTVShows[indexPath.row].isFavorite {
      return buildUnfavoriteAction()
    } else {
      return buildFavoriteAction()
    }
  }
}


extension TVShowsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentTVShows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let showCell: TVShowTableViewCell = tableView.dequeueReusableCell(
      withIdentifier: TVShowTableViewCell.reuseIdentifier,
      for: indexPath) as? TVShowTableViewCell
      else { return UITableViewCell() }
    showCell.load(tvShow: currentTVShows[indexPath.row])
    return showCell
  }
  
}
