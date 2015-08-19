//
//  GithubService.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import Foundation

class GithubService {
  class func repositoriesForSearchTerm(searchTerm : String?, results:[User]?) -> (Void){
    
    var results : [User]!
    let baseURL = "http://localhost:3000"
    let finalURL = baseURL + "?q=\(searchTerm)"
    
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("error")
        } else if let httpResponse = response as? NSHTTPURLResponse {
          
          
          println("http response: \(httpResponse)")
          
          results = GithubJSONParser.userInfoFromJSONData(data)
          
          println("test gits: \(results)")
        }
      }).resume()
    }
  }
}