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
  
  class func usersForSearchTerm(searchTerm : String , completionHandler : (String?, [User]?) -> (Void)){
    
    var results : [User]!
    let baseURL = "https://api.github.com/search/users"
    let finalURL = baseURL + "?q=\(searchTerm)"
    
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
    if let token = KeychainService.loadToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    //Create the url request
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("error")
          completionHandler("Could not connect to server",nil)
        } else if let httpResponse = response as? NSHTTPURLResponse {
          
          println("http response: \(httpResponse.statusCode)")

          switch httpResponse.statusCode {
          case 200...299:
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              let gitAccounts = GithubJSONParser.userInfoFromJSONData(data)
              completionHandler(nil,gitAccounts)
            })
          case 400...499:
            completionHandler("this is our fault", nil)
          case 500...599:
            completionHandler("this is the servers fault", nil)
          default:
            completionHandler("error occurred", nil)
          }
        }
      }).resume()
    }
  }
  
  class func reposForSearchTerm(searchTerm: String, reposCallback : (String?, [Repos]?) -> (Void)){
    
    var results : [Repos]!
    let baseURL = "https://api.github.com/search/repositories"
    let finalURL = baseURL + "?q=\(searchTerm)"
    
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
    if let token = KeychainService.loadToken() {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    if let url = NSURL(string: finalURL){
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("error")
          reposCallback("Could not connect to server", nil)
        } else if let httpResponse = response as? NSHTTPURLResponse {
          println("repos response: \(httpResponse.statusCode)")
          
          switch httpResponse.statusCode {
          case 200...299:
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              let repos = GithubJSONParser.reposInfoFromJSONData(data)
              reposCallback(nil,repos)
            })
          case 400...499:
            reposCallback("this is our fault",nil)
          case 500...599:
            reposCallback("this is the servers fault", nil)
          default:
            reposCallback("error occured",nil)
          }
        }
      }).resume()
    }
  }
  
  
  
  
  
  
}




















