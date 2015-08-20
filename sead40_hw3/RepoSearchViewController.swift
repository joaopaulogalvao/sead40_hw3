//
//  RepoSearchViewController.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
  var userResults = [User]()
  
  @IBOutlet weak var tableviewSearch: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.searchBar.delegate = self
      self.tableviewSearch.dataSource = self
      self.tableviewSearch.delegate = self

      
        // Do any additional setup after loading the view.
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

extension RepoSearchViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
     GithubService.usersForSearchTerm(self.searchBar.text) { (errorDescription, gitUsers) -> (Void) in
    
      if let gitUsers = gitUsers {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          println(gitUsers)
          self.userResults = gitUsers
          self.tableviewSearch.reloadData()
        })
      }
    }
  }
  
}

extension RepoSearchViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.userResults.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let userSearchCell = tableviewSearch.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) as! UITableViewCell
    
//    userSearchCell.tag++
//    let tag = userSearchCell.tag
    
    var infoFromUser = self.userResults[indexPath.row]
    
    userSearchCell.textLabel?.text = infoFromUser.username
    
    //tableviewSearch.reloadData()
    
    return userSearchCell
  }
}









