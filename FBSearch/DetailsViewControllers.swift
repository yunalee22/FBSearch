//
//  DetailsViewControllers.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/27/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftSpinner

class DetailsViewController: UITabBarController {
    
    var albumData: [JSON]!
    var postsData: [JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Updating")
        // Load data into tabs
        updateDetailsViews()
        
        // Hide spinner
        SwiftSpinner.hide()
    }
    
    func updateDetailsViews() {
        // Albums tab
        let albumsViewController = self.viewControllers![0] as! AlbumsViewController
        albumsViewController.data = self.albumData
        albumsViewController.tableView.reloadData()
        
        // Posts tab
        let postsViewController = self.viewControllers![1] as! PostsViewController
        postsViewController.data = self.postsData
    }
    
    
}
