//
//  GithubJSONParser.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import Foundation

class GithubJSONParser {
  
  //MARK: - My profile data
  class func myProfileJSONData (jsonData : NSData) -> User? {
    var error: NSError?
    var myProfileInfo = User()
    
    if let myProfileDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [String : AnyObject] {
      if let myProfileURL = myProfileDict["avatar_url"] as? String, username = myProfileDict["name"] as? String {
        var myProfile = User(username: username, profileImage: nil, userLocation: nil, userEmail: nil, profileImageURL: myProfileURL)
        println("myProfileInfo: \(myProfile)")
      }
    }
    return myProfileInfo
  }
  
  //MARK: - User data
  class func userInfoFromJSONData (jsonData : NSData) -> [User]? {
    var error : NSError?
    var gitUserInfo = [User]()
    
    if let userDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [String : AnyObject] {
      
      if let items = userDict["items"] as? [[String : AnyObject]] {
        
        for item in items {

          if let username = item["login"] as? String, profileImageURL = item["avatar_url"] as? String, userLocation = item["url"] as? String, userEmail = item["repos_url"] as? String {
            
            var gitUser = User(username: username, profileImage: nil, userLocation: userLocation, userEmail: userEmail, profileImageURL: profileImageURL)
            
            gitUserInfo.append(gitUser)
            println("gitUserInfo Array:\(gitUser)")
          }
        }
      }
    }
    return gitUserInfo
  }
  
  //MARK: - Repos data
  class func reposInfoFromJSONData (jsonData : NSData) -> [Repos]? {
    
    var error : NSError?
    var gitReposInfo = [Repos]()
    
    if let reposDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: nil) as? [String : AnyObject] {
      
      if let items = reposDict["items"] as? [[String : AnyObject]] {
        //Access the array of Dictionaries
        for item in items {
          if let repoName = item["name"] as? String, repoDescription = item["description"] as? String {
            
            //Create Git Repo object
            var gitRepo = Repos(repoName: repoName, repoDescription: repoDescription)
            
            gitReposInfo.append(gitRepo)
          }
        }
      }
      
    }
    
    
    return gitReposInfo
  }
  
  
}

