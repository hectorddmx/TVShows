//
//  UITabBarController+StatusBar.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import UIKit


extension UITabBarController {
  open override var childForStatusBarStyle: UIViewController? {
    return selectedViewController
  }
}
