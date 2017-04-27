//
//  AlbumsViewController.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/27/17.
//  Copyright © 2017 USC. All rights reserved.
//

import UIKit
import SwiftyJSON
import FBSDKShareKit

class AlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FBSDKSharingDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var noDataFoundLabel: UILabel!
    
    var data: [JSON]!
    var iconUrl: String!
    var name: String!
    
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
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "album_cell", for: indexPath) as! AlbumCell
        cell.name?.text = data[indexPath.row]["name"].string
        cell.name.sizeToFit()
        cell.setImages(photos: data[indexPath.row]["photos"].array!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
