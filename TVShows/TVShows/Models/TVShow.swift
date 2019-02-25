//
//  TVShow.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import Foundation


struct TVShow: Codable {
 
  enum CodingKeys: String, CodingKey {
    case id
    case externals
    case genres
    case image
    case language
    case name
    case premiered
    case rating
    case runtime
    case status
    case summary
    case updated
    case url
  }
  
  /// JSON Decodable
  let id: Int?
  let externals: Externals?
  let genres: [String]?
  let image: Image?
  let language: String?
  let name: String?
  let premiered: String?
  let rating: Rating?
  let runtime: Int?
  let status: String?
  let summary: String?
  let updated: Int?
  let url: String?
  /// CONFIG
  var isFavorite: Bool {
    return TVShowStore.checkFavoriteStatus(showID: id ?? 0)
  }

  func setFavoriteStatus(favorite: Bool) {
    if favorite {
      saveShow()
    } else {
      deleteShow()
    }
  }

  private func deleteShow() {
    if let id = id {
      TVShowStore.deleteShow(showID: id)
    }
  }

  private func saveShow() {
    let show = TVShowStore.init(
      id: id ?? 0,
      imbd: externals?.imdb ?? "",
      imageMedium: image?.medium ?? "",
      imageOriginal: image?.original ?? "",
      language: language ?? "",
      name: name ?? "",
      premiered: premiered ?? "",
      ratingAverage: rating?.average ?? 0.0,
      runtime: runtime ?? 0,
      status: status ?? "",
      summary: summary ?? "",
      updated: updated ?? 0,
      url: url ?? ""
    )
    show.saveShow()
  }
}



