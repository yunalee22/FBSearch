//
//  HomeViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/25/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import EasyToast

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up slide out menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func onClearButtonClick(_ sender: Any) {
        // Clear text field content
        searchTextField.text = ""
    }
    
    @IBAction func onSearchButtonClick(_ sender: Any) {
        // Validate user input
        if (searchTextField.text == "") {
            self.view.showToast("Enter a valid query!", position: .bottom, popTime: 3, dismissOnTap: false)
            return;
        }
        
        // Show loading animation until data is loaded
        // Execute search
        
        // Show search results
        self.performSegue(withIdentifier: "search_segue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
