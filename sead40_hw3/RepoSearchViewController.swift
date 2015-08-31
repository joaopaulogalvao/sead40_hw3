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
  var repoResults = [Repos]()
  
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
     GithubService.reposForSearchTerm(self.searchBar.text) { (errorDescription, repos) -> (Void) in
    
      if let repos = repos {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          println(repos)
          self.repoResults = repos
          self.tableviewSearch.reloadData()
        })
      }
    }
  }
  
}

extension RepoSearchViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repoResults.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let userSearchCell = tableviewSearch.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) as! UITableViewCell
    
//    userSearchCell.tag++
//    let tag = userSearchCell.tag
    
    var infoFromRepos = self.repoResults[indexPath.row]
    
    userSearchCell.textLabel?.text = infoFromRepos.repoName
    
    //tableviewSearch.reloadData()
    
    return userSearchCell
  }
}

extension RepoSearchViewController : UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    if let repoWebView = storyboard.instantiateViewControllerWithIdentifier("WebRepo") as? WebViewController {
      
      let selectedRepo = self.repoResults[indexPath.row]
      
      println("Row: \(indexPath.row) selected")
      
      repoWebView.selectedRepo = selectedRepo
      
      self.navigationController?.pushViewController(repoWebView, animated: true)
      
    }
    
  }
}


















