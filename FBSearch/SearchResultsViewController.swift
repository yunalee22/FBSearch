//
//  SearchResultsViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/26/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import SwiftSpinner
import SwiftyJSON

class SearchResultsViewController: UITabBarController {
    
    var usersResults: JSON!
    var pagesResults: JSON!
    var eventsResults: JSON!
    var placesResults: JSON!
    var groupsResults: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Load data into tabs
        updateSearchResultViews()
        
        // Hide spinner
        SwiftSpinner.hide()
    }
    
    func updateSearchResultViews() {
        // Users tab
        let usersViewController = self.viewControllers![0] as! UsersViewController
//        let temp = self.viewControllers![0] as! UINavigationController
//        let usersViewController = temp.viewControllers[0] as! UsersViewController
        usersViewController.data = self.usersResults.array
        usersViewController.tableView.reloadData()
        
        // Pages tab
        let pagesViewController = self.viewControllers![1] as! PagesViewController
        pagesViewController.data = self.pagesResults.array
        
        // Events tab
        let eventsViewController = self.viewControllers![2] as! EventsViewController
        eventsViewController.data = self.eventsResults.array
        
        // Places tab
        let placesViewController = self.viewControllers![3] as! PlacesViewController
        placesViewController.data = self.placesResults.array
        
        // Groups tab
        let groupsViewController = self.viewControllers![4] as! GroupsViewController
        groupsViewController.data = self.groupsResults.array
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
