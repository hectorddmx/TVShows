//
//  NetworkingService.swift
//  TVShows
//
//  Created by Hector de Diego on 2/22/19.
//  Copyright © 2019 hector.dd. All rights reserved.
//

import Foundation
import UIKit


enum NetworkError: Error {
  case invalidURL
  case generic
  
  func getMessage() -> String {
    switch self {
    case .invalidURL: return "The URL is invalid"
    case .generic: return "An error occurred while fetching data. Do you want to try again?"
    }
  }
}

class NetworkingService {
  
  let endpoint: String = "http://api.tvmaze.com"
  let pathComponent: String = "shows"
  
  var task: URLSessionTask?
  
  func fetchTVShows(onCompletion: @escaping (TVShowsModel) -> Void) {
    
    func fireErrorCompletion(_ error: Error?) {
      onCompletion(TVShowsModel.init(tvShows: nil, error: error))
    }
    
    guard
      var url: URL = URL(string: endpoint)
      else
    {
      fireErrorCompletion(NetworkError.invalidURL)
      return
    }
    
    url = url.appendingPathComponent(pathComponent)
    task?.cancel()
    task = URLSession.shared.dataTask(with: url) {
      [weak self]
      data, response, error in
      guard let self = self else { return }
      DispatchQueue.main.async {
        
        if let error = error {
          guard (error as NSError).code != NSURLErrorCancelled
            else { return }
          fireErrorCompletion(error)
          return
        }
        
        guard let data = data else {
          fireErrorCompletion(error)
          return
        }
        
        guard let response = response else {
          fireErrorCompletion(error)
          return
        }
        
        dump(response)
        
        do {
          let result = try JSONDecoder().decode([TVShow].self, from: data)
          onCompletion(TVShowsModel.init(tvShows: result, error: nil))
        } catch {
          fireErrorCompletion(error)
        }
      }
    }
    task?.resume()
  }
}
