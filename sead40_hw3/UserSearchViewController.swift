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
  var gitHubUser : User?
  lazy var userImageQueue = NSOperationQueue()
  
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
    
    cell.layer.cornerRadius = 50
    // Set the imageView for nil each time it dequeue a cell. 
    cell.imageViewUser.image = nil
    
    var userImage = userResults[indexPath.row]
    println("Users image:\(userImage)")
    
    // If there is an image set an image for a user
    if let profileImage = self.gitHubUser?.profileImage {
      
      cell.imageViewUser.image = profileImage
    } else {
      
      //Only load when needed
      userImageQueue.addOperationWithBlock({ () -> Void in
        //Check if there is an URL - set indexPath for each url / check Data and image
        if let imageURL = NSURL(string: self.userResults[indexPath.row].profileImageURL),
        data = NSData(contentsOfURL: imageURL),
          image = UIImage(data: data){
            
            //Check for image size depending on resolution
            var size : CGSize
            switch UIScreen.mainScreen().scale {
            case 2:
              size = CGSize(width: 160, height: 160)
            case 3:
              size = CGSize(width: 240, height: 240)
              println("Size 240")
            default:
              size = CGSize(width: 80, height: 80)
              println("default")
            }
            
            let resizedImage = ImageSizer.resizeImage(image, size: size)
            
            // Send operation back to the main Queue
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              
              userImage.profileImage = resizedImage
              
              self.userResults[indexPath.row] = userImage
              
              cell.imageViewUser?.image = resizedImage
              
            })
        }
      })
      
    }
    
    return cell
  }
  
  
}














