//
//  GroupsViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/26/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import SwiftyJSON

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var groupsData: [JSON]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up slide out menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
