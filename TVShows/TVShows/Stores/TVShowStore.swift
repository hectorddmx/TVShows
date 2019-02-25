//
//  TVShowStore.swift
//  TVShows
//
//  Created by Hector de Diego on 2/24/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class TVShowStore: Object {
  dynamic var id = 0
  dynamic var imbd = ""
  dynamic var imageMedium = ""
  dynamic var imageOriginal = ""
  dynamic var language = ""
  dynamic var name = ""
  dynamic var premiered = ""
  dynamic var ratingAverage = 0.0
  dynamic var runtime = 0
  dynamic var status = ""
  dynamic var summary = ""
  dynamic var updated = 0
  dynamic var url = ""
  
  convenience init(
    id: Int,
    imbd: String,
    imageMedium: String,
    imageOriginal: String,
    language: String,
    name: String,
    premiered: String,
    ratingAverage: Double,
    runtime: Int,
    status: String,
    summary: String,
    updated: Int,
    url: String
    ) {
    self.init()
    self.id = id
    self.imbd = imbd
    self.imageMedium = imageMedium
    self.imageOriginal = imageOriginal
    self.language = language
    self.name = name
    self.premiered = premiered
    self.ratingAverage = ratingAverage
    self.runtime = runtime
    self.status = status
    self.summary = summary
    self.updated = updated
    self.url = url
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }

  static func getSavedShows() -> [TVShowStore] {
    var shows: [TVShowStore] = []
    let realm = try! Realm()
    let results = realm.objects(TVShowStore.self)

    if !results.isEmpty {
      shows = Array(results)
    }

    return shows
  }
  
  func saveShow() {
    let realm = try! Realm()
    try! realm.write {
      realm.add(self)
    }
    print("Show with id: \(id ?? 0) has been saved")
  }

  static func checkFavoriteStatus(showID: Int) -> Bool {
    let realm = try! Realm()

    guard
      let _ = realm.object(ofType: TVShowStore.self, forPrimaryKey: showID)
      else {
      print("Show with id: \(showID) is not favorite")
      return false
    }

    print("Show with id: \(showID) is a favorite")
    return true

  }
  
  static func deleteShow(showID: Int) {
    let realm = try! Realm()
    
    guard
      let show = realm.object(ofType: TVShowStore.self, forPrimaryKey: showID)
      else { return }
    
    try! realm.write {
      realm.delete(show)
    }
    print("Show with id: \(showID) was deleted")
  }
  
  override var description: String {
    return """
    TVShowStore {
      "id" = \(id),
      "imbd" = "\(imbd)",
      "imageMedium" = "\(imageMedium)",
      "imageOriginal" = "\(imageOriginal)",
      "language" = "\(language)",
      "name" = "\(name)",
      "premiered" = "\(premiered)",
      "ratingAverage" = "\(ratingAverage)",
      "runtime" = "\(runtime)",
      "status" = "\(status)",
      "summary" = "\(summary)",
      "updated" = "\(updated)",
      "url" = "\(url)",
    }
    """
  }
}
