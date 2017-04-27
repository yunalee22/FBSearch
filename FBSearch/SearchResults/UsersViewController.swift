//
//  UsersViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/26/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import SwiftyJSON

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var usersData: [JSON]?
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up slide out menu
//        if self.revealViewController() != nil {
//            menuButton.target = self.revealViewController()
//            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
        
        // Set enabled for pagination buttons
        previousButton.isEnabled = false
        if (usersData != nil) {
            if (usersData!.count <= 10) {
                nextButton.isEnabled = false;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (usersData != nil) {
            return min(usersData!.count - currentPage * 10, 10)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath) as! ResultCell
        let ind = 10 * currentPage + indexPath.row
        
        // Populate cell dataprin
        cell.userID = usersData![ind]["id"].string
        cell.nameLabel?.text = usersData![ind]["name"].string
        let url = URL(string: usersData![ind]["picture"]["data"]["url"].string!)
        let data = try? Data(contentsOf: url!)
        cell.iconImageView?.image = UIImage(data: data!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a cell")
    }
    
    @IBAction func onPreviousButtonClick(_ sender: Any) {
        currentPage -= 1
        updateEnabled()
        usersTableView.reloadData()
    }
    
    @IBAction func onNextButtonClick(_ sender: Any) {
        currentPage += 1
        updateEnabled()
        usersTableView.reloadData()
    }
    
    func updateEnabled() {
        if (usersData == nil) {
            previousButton.isEnabled = false
            nextButton.isEnabled = false
            return
        }
        
        if (usersData!.count <= 10) {
            previousButton.isEnabled = false
            nextButton.isEnabled = false
            return
        }
        
        if (currentPage == 0) {
            previousButton.isEnabled = false
        } else {
            previousButton.isEnabled = true
        }
        
        if (currentPage == Int(usersData!.count / 10)) {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
