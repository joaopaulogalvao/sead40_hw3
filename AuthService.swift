//
//  AuthService.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/19/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class AuthService {
  
  class func performInitialRequest(){
    
    UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(kClientID)&redirect_uri=sead40hw3://oauth&scope=user,repo")!)
    
  }
  
  class func exchangeCodeInURL(codeURL : NSURL) {
    if let code = codeURL.query {
      
      let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?\(code)&client_id=\(kClientID)&client_secret=\(kClientSecret)")!)
      
      request.HTTPMethod = "POST"
      
      //Response from GitHub / Header
      request.setValue("application/json", forHTTPHeaderField: "Accept")
      
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let httpResponse = response as? NSHTTPURLResponse {
          
          println(httpResponse.statusCode)
          
          var jsonError : NSError?
          
          if let rootObject = NSJSONSerialization.JSONObjectWithData(data , options: nil, error: &jsonError) as? [String : AnyObject], token = rootObject["access_token"] as? String {
            
            
            
          }
        }
      }).resume()
      
      println(request.URL)
      
    }
  }
}
