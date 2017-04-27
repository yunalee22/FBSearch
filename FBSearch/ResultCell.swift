import Foundation
import SwiftyJSON

class ResultCell : UITableViewCell {
    
    var id: String!
    var data: [String : JSON]!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func onFavoriteButtonClick(_ sender: Any) {
        
    }
}
