import Foundation

class ResultCell : UITableViewCell {
    
    var id: String!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func onFavoriteButtonClick(_ sender: Any) {
        
    }
}
