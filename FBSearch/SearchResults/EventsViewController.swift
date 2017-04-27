//
//  EventsViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/26/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftSpinner

class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var data: [JSON]?
    var currentPage = 0
    
    var albumsData: [JSON]!
    var postsData: [JSON]!
    var originData: [String : JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up slide out menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Set enabled for pagination buttons
        previousButton.isEnabled = false
        if (data != nil) {
            if (data!.count <= 10) {
                nextButton.isEnabled = false;
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (tableView != nil) {
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "details_segue") {
            let destViewController:DetailsViewController = segue.destination as! DetailsViewController
            destViewController.albumData = self.albumsData
            destViewController.postsData = self.postsData
            destViewController.originData = self.originData
        }
    }
    
    func showDetails(id: String) {
        // Show spinner
        SwiftSpinner.show("Loading data...")
        
        let url = "http://fbsearch571-env.us-west-2.elasticbeanstalk.com/index.php?action=loadDetails&id=" + id
        print (url)
        
        Alamofire.request(url).responseData { (responseData) -> Void in
            guard let jsonData = responseData.result.value else {
                self.view.showToast("Failed to retrieve details.", position: .bottom, popTime: 3, dismissOnTap: false)
                SwiftSpinner.hide()
                return
            }
            
            let json = JSON(data: jsonData)
            self.albumsData = json["albums"].array
            self.postsData = json["posts"].array
            
            // Show details
            self.performSegue(withIdentifier: "details_segue", sender: self)
            
            // Hide spinner
            SwiftSpinner.hide()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! ResultCell
        let id = selectedCell.id
        self.originData = selectedCell.data
        showDetails(id: id!)
        print ("Showing details for id " + id!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (data != nil) {
            return min(data!.count - currentPage * 10, 10)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath) as! ResultCell
        let ind = 10 * currentPage + indexPath.row
        
        // Populate cell
        cell.id = data![ind]["id"].string
        cell.data = data![ind].dictionary
        cell.nameLabel?.text = data![ind]["name"].string
        let imgUrl = URL(string: data![ind]["picture"]["data"]["url"].string!)
        let imgData = try? Data(contentsOf: imgUrl!)
        cell.iconImageView?.image = UIImage(data: imgData!)
        
        return cell
    }
    
    @IBAction func onPreviousButtonClick(_ sender: Any) {
        currentPage -= 1
        updateEnabled()
        tableView.reloadData()
    }
    
    @IBAction func onNextButtonClick(_ sender: Any) {
        currentPage += 1
        updateEnabled()
        tableView.reloadData()
    }
    
    func updateEnabled() {
        if (data == nil) {
            previousButton.isEnabled = false
            nextButton.isEnabled = false
            return
        }
        
        if (data!.count <= 10) {
            previousButton.isEnabled = false
            nextButton.isEnabled = false
            return
        }
        
        if (currentPage == 0) {
            previousButton.isEnabled = false
        } else {
            previousButton.isEnabled = true
        }
        
        if (currentPage == Int(data!.count / 10)) {
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
