//
//  FavoriteTableViewCell.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 28/10/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCatFavTable: UIImageView!
    
    @IBOutlet weak var labelNameCatFavTable: UILabel!
    
    @IBOutlet weak var labelDescriptionFavTable: UILabel!
    
    static var idCelulaFavTableView = "celulaCustomizada"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
