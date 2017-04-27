//
//  PostCell.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/27/17.
//  Copyright © 2017 USC. All rights reserved.
//

import Foundation

class PostCell : UITableViewCell {
    
    var id: String!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func onFavoriteButtonClick(_ sender: Any) {
        
    }
}
