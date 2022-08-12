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
    
    static var idCell = "celulaCustomizada"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        labelNameCatFavTable.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelNameCatFavTable.textColor = .darkGray
        labelDescriptionFavTable.numberOfLines = 0
        labelDescriptionFavTable.font = UIFont.systemFont(ofSize: 15.0)
        imageCatFavTable.layer.cornerRadius = 55
        imageCatFavTable.layer.masksToBounds = true
        imageCatFavTable.contentMode = .scaleAspectFill
    }
    
    func updateCell(withCatEntity model: CatEntity) {
        labelNameCatFavTable.text = model.catName
        labelDescriptionFavTable.text = model.catDescription
 
        if let image = model.catImage {
            let url = URL(string: image)
            imageCatFavTable.kf.setImage(with: url, placeholder: UIImage(named: "placeHolderCat"), options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        } else {
            imageCatFavTable.image = UIImage(named: "placeHolderCat")
        }
    }
    
}
