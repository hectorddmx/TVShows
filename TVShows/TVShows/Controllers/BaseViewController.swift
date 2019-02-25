//
//  BaseViewController.swift
//  TVShows
//
//  Created by Hector de Diego on 2/25/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  // MARK: - Configuration
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func prepareNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func showActionAlert(
    vc: UIViewController,
    okActionHandler: @escaping (UIAlertAction) -> Void
    ) {
    
    let alertController = UIAlertController(
      title: "Delete favorite?",
      message: nil,
      preferredStyle: .actionSheet
    )
    let okAction = UIAlertAction(title: "Delete", style: .destructive, handler: okActionHandler)
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    vc.present(alertController, animated: true, completion: nil)
  }
  
  func showErrorMessage(
    vc: UIViewController,
    okActionHandler: @escaping (UIAlertAction) -> Void
    ) {
    
    let alertController = UIAlertController(
      title: "Delete favorite?",
      message: nil,
      preferredStyle: .actionSheet
    )
    let okAction = UIAlertAction(title: "Delete", style: .destructive, handler: okActionHandler)
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    vc.present(alertController, animated: true, completion: nil)
  }
}
