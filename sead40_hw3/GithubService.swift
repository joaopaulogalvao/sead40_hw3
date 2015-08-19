//
//  GithubService.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import Foundation

class GithubService {
  
  static let sharedService = GithubService()
  
  private init() {}
  
  class func repositoriesForSearchTerm(searchTerm : (String?, [User]?) -> (Void)){
    
    var results : [User]!
    let baseURL = "http://localhost:3000"
    let finalURL = baseURL + "?q=\(searchTerm)"
    
    //Create the url request
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("error")
          searchTerm("Could not connect to server",nil)
        } else if let httpResponse = response as? NSHTTPURLResponse {
          
          println("http response: \(httpResponse.statusCode)")

          switch httpResponse.statusCode {
          case 200...299:
            let gitAccounts = GithubJSONParser.userInfoFromJSONData(data)
            searchTerm(nil,gitAccounts)
          case 400...499:
            searchTerm("this is our fault", nil)
          case 500...599:
            searchTerm("this is the servers fault", nil)
          default:
            searchTerm("error occurred", nil)
          }
        }
      }).resume()
    }
  }
}