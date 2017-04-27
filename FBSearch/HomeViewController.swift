//
//  HomeViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/25/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import EasyToast
import SwiftSpinner
import Alamofire
import CoreLocation
import SwiftyJSON

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    let locationManager = CLLocationManager()
    var latitude, longitude: Double!
    
    var usersResults, pagesResults, eventsResults, placesResults, groupsResults: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up slide out menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Request location manager authorization
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc:CLLocationCoordinate2D = locationManager.location!.coordinate
        latitude = loc.latitude
        longitude = loc.longitude
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "search_segue") {
            let destViewController:SearchResultsViewController = segue.destination as! SearchResultsViewController
            destViewController.usersResults = self.usersResults
            destViewController.pagesResults = self.pagesResults
            destViewController.eventsResults = self.eventsResults
            destViewController.placesResults = self.placesResults
            destViewController.groupsResults = self.groupsResults
        }
    }
    
    @IBAction func onClearButtonClick(_ sender: Any) {
        // Clear text field content
        searchTextField.text = ""
    }
    
    @IBAction func onSearchButtonClick(_ sender: Any) {
        // Check if location services enabled
        if !(CLLocationManager.locationServicesEnabled()) {
            self.view.showToast("Please enable location services.", position: .bottom, popTime: 3, dismissOnTap: false)
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // Validate user input
        if (searchTextField.text == "") {
            self.view.showToast("Enter a valid query!", position: .bottom, popTime: 3, dismissOnTap: false)
            return
        }
        
        // Execute search
        executeSearch(searchQuery: self.searchTextField.text!)
    }
    
    func executeSearch(searchQuery: String) {
        // Show spinner
        SwiftSpinner.show("Loading data...")
        
        let url = "http://fbsearch571-env.us-west-2.elasticbeanstalk.com/index.php?action=search&search=" + searchQuery + "&latitude=" + String(format:"%f", latitude) + "&longitude=" + String(format: "%f", longitude)
        print (url)
        
        Alamofire.request(url).responseData { (responseData) -> Void in
            guard let jsonData = responseData.result.value else {
                self.view.showToast("Failed to retrieve search data.", position: .bottom, popTime: 3, dismissOnTap: false)
                SwiftSpinner.hide()
                return
            }
            
            let json = JSON(data: jsonData)
            self.usersResults = json["users"]["data"]
            self.pagesResults = json["pages"]["data"]
            self.eventsResults = json["events"]["data"]
            self.placesResults = json["places"]["data"]
            self.groupsResults = json["groups"]["data"]
            
            // Show search results
            self.performSegue(withIdentifier: "search_segue", sender: self)
        }
    }
    
}
