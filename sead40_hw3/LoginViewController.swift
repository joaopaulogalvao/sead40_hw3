//
//  LoginViewController.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/19/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewDidAppear(animated: Bool) {
    
    if let token = KeychainService.loadToken() {
      
      
      
    } else {
      AuthService.performInitialRequest()
    }
    
  }
    

  @IBAction func performLogin(sender: AnyObject) {
    
    println("pressed")
    
    
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: kTokenNotification, object: nil)
  }

}
