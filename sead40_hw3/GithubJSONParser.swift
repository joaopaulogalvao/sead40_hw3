//
//  GithubJSONParser.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import Foundation

class GithubJSONParser {
  
  class func userInfoFromJSONData (jsonData : NSData) -> [User]? {
    var error : NSError?
    var gitUserInfo = [User]()
    
    if let userDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [String : AnyObject] {
      
      if let items = userDict["items"] as? [[String : AnyObject]] {
        
        for item in items {

          if let username = item["login"] as? String, gitName = item["avatar_url"] as? String, userLocation = item["url"] as? String, userEmail = item["repos_url"] as? String {
            
            var gitUser = User(username: username, gitName: gitName, userLocation: userLocation, userEmail: userEmail)
            
            gitUserInfo.append(gitUser)
            println("gitUserInfo Array:\(gitUser)")
          }
        }
      }
    }
    return gitUserInfo
  }
  
//  class func reposInfoFromJSONData (jsonData : NSData) -> [Repos]? {
//  
//  }
//  
  
}

