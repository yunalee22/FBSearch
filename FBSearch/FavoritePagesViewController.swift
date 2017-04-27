//
//  FavoritePagesViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/27/17.
//  Copyright © 2017 USC. All rights reserved.
//

import Foundation

class FavoritePagesViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up slide out menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
