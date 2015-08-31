//
//  WebViewController.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/22/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  var selectedRepo : Repos!
  
  //@IBOutlet weak var webViewRepos: UIWebView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let webView = WKWebView(frame: view.frame)
      view.addSubview(webView)

      
        // Do any additional setup after loading the view.
//      let baseURL = "https://api.github.com/search/repositories"
//      let finalURL = baseURL + "?q=\(selectedRepo!.repoURL)"
      
//      if let urlRequest = NSURL(string: selectedRepo!.repoURL){
        let urlRequest = NSURLRequest(URL: NSURL(string: selectedRepo.repoURL)!)
        webView.loadRequest(urlRequest)
//      }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
