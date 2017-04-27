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
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var usersResults: JSON!
    var pagesResults: JSON!
    var eventsResults: JSON!
    var placesResults: JSON!
    var groupsResults: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up slide out menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Load data into tabs
        updateSearchResultViews()
        
        
    }
    
    func updateSearchResultViews() {
        // Users tab
        let usersViewController = self.viewControllers![0] as! UsersViewController
        usersViewController.usersData = self.usersResults.array
        usersViewController.usersTableView.reloadData()
        
        // Pages tab
        let pagesViewController = self.viewControllers![1] as! PagesViewController
        pagesViewController.pagesData = self.pagesResults.array
        
        
        // Events tab
        let eventsViewController = self.viewControllers![2] as! EventsViewController
        eventsViewController.eventsData = self.eventsResults.array
        
        
        // Places tab
        let placesViewController = self.viewControllers![3] as! PlacesViewController
        placesViewController.placesData = self.placesResults.array
        
        
        // Groups tab
        let groupsViewController = self.viewControllers![4] as! GroupsViewController
        groupsViewController.groupsData = self.groupsResults.array
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
