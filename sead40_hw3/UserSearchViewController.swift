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
  let userImageQueue = NSOperationQueue()
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBarUser: UISearchBar!
  
  let kCornerRadius : CGFloat = 50.0
  
  //MARK: Life cycle methods
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
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.delegate = self
  }

  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.delegate = nil
  }
    

  //MARK: Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
    if segue.identifier == "showDetailView" {
      if let detailViewController = segue.destinationViewController as? DetailViewController {
        
        let myIndexPath = self.collectionView.indexPathsForSelectedItems()
        
        if let indexPath = self.collectionView?.indexPathsForSelectedItems() {
          
//          let selectedRow: AnyObject? = indexPath.first
          let selectedUser = self.userResults.first
//          println("Row \(indexPath.row) selected")
          
          
          detailViewController.selectedUserName = selectedUser
          
          
        }
        
        println("Detail Clicked")
        
      }
    }
  }


}

//MARK: - UISearchBarDelegate

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

//MARK: - UICollectionViewDelegate

extension UserSearchViewController : UICollectionViewDelegate {
  
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    
    if let detailViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileView") as? DetailViewController {
      
        let selectedUser = self.userResults[indexPath.row]
        
        println("Row \(indexPath.row) selected")
      
        //Pass selecteded user reference to next viewcontroller
        detailViewController.selectedUserName = selectedUser
        
        println(selectedUser)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
      }
      
    
  }
  
  
}

//MARK: - UICollectionViewDataSource

extension UserSearchViewController : UICollectionViewDataSource{
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userResults.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("userCell", forIndexPath: indexPath) as! CollectionViewUserCell
    
    cell.layer.cornerRadius = kCornerRadius
    // Set the imageView for nil each time it dequeue a cell.
    cell.imageViewUser.image = nil
    cell.hidden = false
    cell.alpha = 1.0
    
    cell.tag++
    let tag = cell.tag
    
    
    
    var userImage = userResults[indexPath.row]
    println("Users image:\(userImage)")
    
    // If there is an image set an image for a user
    if let profileImage = userImage.profileImage {
      
      cell.imageViewUser.image = profileImage
      
    } else {
      
      //The reason Brad's is async is because in his service he made a queue
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
            ImageService.fetchProfileImage(userImage.profileImageURL,imageQueue:self.userImageQueue, completionHandler: { (image) -> () in
              
              userImage.profileImage = resizedImage
              
              self.userResults[indexPath.row] = userImage
              
              if cell.tag == tag {
                cell.imageViewUser?.image = resizedImage
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                  cell.alpha = 1
                  // Adjust rounded border
                  cell.imageViewUser.layer.masksToBounds = false
                  cell.imageViewUser.layer.cornerRadius = cell.imageViewUser.frame.height/2
                  cell.imageViewUser.clipsToBounds = true
                })
                
              }
 
            })
        }
      })
      
    }
    
    return cell
  }
  
  
}

extension UserSearchViewController : UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return toVC is DetailViewController ? ToUserDetailAnimationController() : nil
    
  }
}












