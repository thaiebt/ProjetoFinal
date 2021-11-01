//
//  CelulaCatsCustomizadaCollectionViewCell.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import UIKit

class CelulaCatsCustomizadaCollectionViewCell: UICollectionViewCell {
    
    static var idCelulaCollectionView = "celulaCustomizada"
    
    @IBOutlet weak var labelDay: UILabel!
    
    @IBOutlet weak var nameCatCollectionView: UILabel!
    
    @IBOutlet weak var imageCatCollectionView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
