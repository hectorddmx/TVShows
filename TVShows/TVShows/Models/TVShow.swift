//
//  TVShow.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import Foundation

struct TVShow: Codable {
  let externals: Externals
  let genres: [String]
  let id: Int
  let image: Image
  let language: String
  let name: String
  let officialSite: String
  let premiered: String
  let rating: Rating
  let runtime: Int
  let status: String
  let summary: String
  let updated: Int
  let url: String
}
