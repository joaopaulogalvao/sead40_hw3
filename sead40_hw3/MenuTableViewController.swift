//
//  MenuTableViewController.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

  //MARK: Properties
  var myProfile : User!
  let myProfileUserImageQueue = NSOperationQueue()
  
  //MARK: Constants
  let kSize2Width : Int = 160
  let kSize2Height : Int = 160
  let kSize3Width : Int = 240
  let kSize3Height : Int = 240
  let kSizeDefaultWidth : Int = 80
  let kSizeDefaultHeight : Int = 80
  
  //MARK: Outlets
  @IBOutlet weak var imgViewMyProfile: UIImageView!
  @IBOutlet weak var labelMyProfile: UILabel!
  
  //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      
      AuthService.performInitialRequest()
      
      let baseURL = "https://api.github.com/user"
    
      GithubService.myProfileSearch(baseURL) { (errorDescription, myProfile) -> (Void) in
        println("myProfileInfo to Menu: \(myProfile)")
        self.labelMyProfile.text = myProfile?.username
        if let profileImage = myProfile?.profileImage {
          
          self.imgViewMyProfile.image = profileImage
          
        } else {
          
          self.myProfileUserImageQueue.addOperationWithBlock({ () -> Void in
            
            //Check if there is an URL - set indexPath for each url / check Data and image
            if let imageURL = NSURL(string: myProfile!.profileImageURL),
              data = NSData(contentsOfURL: imageURL),
              image = UIImage(data: data){
                
                //Check for image size depending on resolution
                var size : CGSize
                switch UIScreen.mainScreen().scale {
                case 2:
                  size = CGSize(width: self.kSize2Width, height: self.kSize2Height)
                case 3:
                  size = CGSize(width: self.kSize3Width, height: self.kSize3Height)
                  println("Size 240")
                default:
                  size = CGSize(width: self.kSizeDefaultWidth, height: self.kSizeDefaultHeight)
                  println("default")
                }
                
                let resizedImage = ImageSizer.resizeImage(image, size: size)
                
                // Adjust rounded border
                self.imgViewMyProfile.layer.masksToBounds = false
                self.imgViewMyProfile.layer.cornerRadius = self.imgViewMyProfile.frame.height/2
                self.imgViewMyProfile.clipsToBounds = true
                
                self.imgViewMyProfile.image = resizedImage
                
                
                //Only load when needed
//                ImageService.fetchProfileImage(myProfile!.profileImageURL, imageQueue: self.myProfileUserImageQueue, completionHandler: { (image) -> () in
//                  if let profileImage = myProfile!.profileImage {
//                    //self.myProfile.profileImage = resizedImage
//                    self.imgViewMyProfile.image = resizedImage
//                    println("Resized Image:\(resizedImage)")
//                  }
//                })
            }
          })
        }
        
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
