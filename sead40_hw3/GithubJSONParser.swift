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

          if let username = item["name"] as? String, gitName = item["full_name"] as? String, userLocation = item["html_url"] as? String, userEmail = item["url"] as? String {
            
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

