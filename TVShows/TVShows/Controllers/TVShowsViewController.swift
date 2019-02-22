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
  }
  public var screenState: ScreenState?
 
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
  
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareNavigationBar()
  }
  
   // MARK: - Navigation
}
