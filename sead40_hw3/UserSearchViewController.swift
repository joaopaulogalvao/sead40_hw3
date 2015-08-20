//
//  UserSearchViewController.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/19/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

  var userResults = [User]()
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBarUser: UISearchBar!
  
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     self.collectionView.dataSource = self
      self.collectionView.delegate = self
      self.searchBarUser.delegate = self
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

extension UserSearchViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    GithubService.usersForSearchTerm(self.searchBarUser.text) { (errorDescription, users) -> (Void) in
      
      if let users = users {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          println(users)
          self.userResults = users
          self.collectionView.reloadData()
        })
      }
    }
  }
  
}

extension UserSearchViewController : UICollectionViewDelegate {
  
  
  
  
}

extension UserSearchViewController : UICollectionViewDataSource{
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userResults.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("userCell", forIndexPath: indexPath) as! CollectionViewUserCell
    var userImage = userResults[indexPath.row]
    println("Users image:\(userImage)")
    
    return cell
  }
  
  
}














