//
//  FavTableViewCell.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 28/10/21.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageFavoriteHeart: UIImageView!
    
    @IBOutlet weak var labelAddFavorite: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
