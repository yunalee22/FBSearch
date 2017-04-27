//
//  AlbumCell.swift
//  FBSearch
//
//  Created by Yuna Lee on 4/27/17.
//  Copyright © 2017 USC. All rights reserved.
//

import Foundation
import SwiftyJSON

class AlbumCell : UITableViewCell {
    
    @IBOutlet weak var imagesView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image_1: UIImageView!
    @IBOutlet weak var image_2: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        hideImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setImages(photos: [JSON]) {
        if (photos.count == 0) {
            image_1.isHidden = true
            image_2.isHidden = true
        }
        if (photos.count == 1) {
            let url_1 = URL(string: photos[0].string!)
            let data_1 = try? Data(contentsOf: url_1!)
            image_1.image = UIImage(data: data_1!)
            
            image_1.isHidden = false
            image_2.isHidden = true
            return
        }
        if (photos.count == 2) {
            let url_1 = URL(string: photos[0].string!)
            let data_1 = try? Data(contentsOf: url_1!)
            image_1.image = UIImage(data: data_1!)
            
            let url_2 = URL(string: photos[1].string!)
            let data_2 = try? Data(contentsOf: url_2!)
            image_2.image = UIImage(data: data_2!)
            
            image_1.isHidden = false
            image_2.isHidden = false
            return
        }
    }
    
    func showImages() {
        imagesView.isHidden = false
    }
    
    func hideImages() {
        imagesView.isHidden = true
    }
    
}
