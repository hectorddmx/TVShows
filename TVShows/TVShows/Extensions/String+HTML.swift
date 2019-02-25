//
//  String+HTML.swift
//  TVShows
//
//  Created by Hector de Diego on 2/25/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import Foundation


extension String {
  var htmlToAttributedString: NSAttributedString? {
    guard let data = data(using: .utf8) else { return NSAttributedString() }
    do {
      return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch {
      return NSAttributedString()
    }
  }
  var htmlToString: String {
    return htmlToAttributedString?.string ?? ""
  }
}
