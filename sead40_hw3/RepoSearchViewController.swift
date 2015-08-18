//
//  RepoSearchViewController.swift
//  sead40_hw3
//
//  Created by Joao Paulo Galvao Alves on 8/18/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
      self.searchBar.delegate = self
      

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
    GithubService.repositoriesForSearchTerm(searchBar.text)
  }
  
}
