//
//  PostsViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/27/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import SwiftyJSON
import FBSDKShareKit

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FBSDKSharingDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var noDataFoundLabel: UILabel!
    
    var data: [JSON]!
    var imgUrl: String!
    var iconUrl: String!
    var name: String!
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add "No data found." label
        noDataFoundLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        noDataFoundLabel.center = view.center
        noDataFoundLabel.textAlignment = .center
        noDataFoundLabel.text = "No data found."
        self.view.addSubview(noDataFoundLabel)
        noDataFoundLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableIfDataExists();
    }
    
    @IBAction func onOptionsButtonClick(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        
        let favoritesActionButton = UIAlertAction(title: "Add to favorites", style: .default)
        { _ in
            print("Add to favorites")
        }
        actionSheetController.addAction(favoritesActionButton)
        
        let shareActionButton = UIAlertAction(title: "Share", style: .default)
        { _ in
            print("Share")
            
            // Share to Facebook
            let shareContent: FBSDKShareLinkContent = FBSDKShareLinkContent();
            shareContent.contentURL = URL(string: "https://fb-search-571.appspot.com")
            shareContent.contentTitle = self.name
            shareContent.contentDescription = "FB Share for CSCI 571"
            shareContent.imageURL = URL(string: self.iconUrl)
            let shareDialog: FBSDKShareDialog = FBSDKShareDialog()
            shareDialog.shareContent = shareContent
            shareDialog.delegate = self
            shareDialog.fromViewController = self
            shareDialog.show()
        }
        actionSheetController.addAction(shareActionButton)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print(results)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print(error)
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("Sharer cancelled.")
    }
    
    func reloadTableIfDataExists() {
        if (tableView == nil || data == nil) {
            tableView.isHidden = true
            noDataFoundLabel.isHidden = false
            return
        }
        if (data != nil) {
            if (data.count == 0) {
                tableView.isHidden = true
                noDataFoundLabel.isHidden = false
                return
            }
        }
        tableView.reloadData()
        tableView.isHidden = false
        noDataFoundLabel.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (data != nil) {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post_cell", for: indexPath) as! PostCell
        cell.messageLabel?.text = data[indexPath.row]["message"].string
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let date: Date? = dateFormatter.date(from: data[indexPath.row]["created_time"].string!)
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        cell.timestampLabel?.text = dateFormatter.string(from: date!)
        
        let imgData = try? Data(contentsOf: URL(string: imgUrl)!)
        cell.iconImageView?.image = UIImage(data: imgData!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
