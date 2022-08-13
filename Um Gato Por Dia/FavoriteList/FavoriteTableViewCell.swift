//
//  FavoriteTableViewCell.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 28/10/21.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var nameAndPreviewView: SimpleCardView = {
        let view = SimpleCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static var idCell = "celulaCustomizada"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(image)
        contentView.addSubview(nameAndPreviewView)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 110),
            image.widthAnchor.constraint(equalToConstant: 110),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameAndPreviewView.topAnchor.constraint(equalTo: image.topAnchor),
            nameAndPreviewView.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8),
            nameAndPreviewView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            nameAndPreviewView.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -8),
            
        ])
    }
    
    func updateCell(withCatEntity model: CatEntity) {
        nameAndPreviewView.updateView(title: model.catName ?? "",
                                      content: model.catDescription ?? "" ,
                                      action: nil)
 
        if let strImage = model.catImage {
            let url = URL(string: strImage)
            image.kf.setImage(with: url, placeholder: UIImage(named: "placeHolderCat"), options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        } else {
            image.image = UIImage(named: "placeHolderCat")
        }
    }
    
}
