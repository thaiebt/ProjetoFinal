//
//  CelulaCatsCustomizadaCollectionViewCell.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import UIKit
import Kingfisher

class CelulaCatsCustomizadaCollectionViewCell: UICollectionViewCell {
    
    static var cellId = "celulaCustomizada"
    
    @IBOutlet weak var labelDay: UILabel!
    
    @IBOutlet weak var nameCatCollectionView: UILabel!
    
    @IBOutlet weak var imageCatCollectionView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }
    
    private func setupCell() {
        imageCatCollectionView.contentMode = .scaleAspectFill
        contentView.layer.cornerRadius = 15
        nameCatCollectionView.textColor = .white
        nameCatCollectionView.textAlignment = .center
        labelDay.textColor = .white
        labelDay.textAlignment = .center
        labelDay.font = UIFont.boldSystemFont(ofSize: 25.0)
    }

    func updateCell(withModel model: CatsResponseModel, index: Int) {
        if let image = model.image?.url {
            let url = URL(string: image)
            imageCatCollectionView.kf.setImage(with: url,
                                                     placeholder: UIImage(named: "placeHolderCat"),
                                                     options: [
                                                        .transition(ImageTransition.fade(0.5)),
                                                        .cacheOriginalImage
                                                        ],
                                                     progressBlock: nil ,
                                                     completionHandler: nil)
       }else {
            imageCatCollectionView.image = UIImage(named: "placeHolderCat")
        }
    
        nameCatCollectionView.text = model.name
        labelDay.text = ("Day \(index + 1)")
    }
}
