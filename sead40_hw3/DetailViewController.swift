//
//  DetailViewController.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/20/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var selectedUserName : User?
  var userImage : UIImage?
  var user_name : String?
  var users = [User]()
  
  @IBOutlet weak var labelUserDetail: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      
      
          self.labelUserDetail.text = self.selectedUserName?.username
          
      
      
      
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
