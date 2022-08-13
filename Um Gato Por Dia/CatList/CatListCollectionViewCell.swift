//
//  CelulaCatsCustomizadaCollectionViewCell.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import UIKit
import Kingfisher

class CatListCollectionViewCell: UICollectionViewCell {
    
    static var cellId = "celulaCustomizada"
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var fadeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.40)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.addSubview(image)
        contentView.addSubview(fadeView)
        contentView.addSubview(dayLabel)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            fadeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            fadeView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            fadeView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            fadeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            dayLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            
            nameLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: dayLabel.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: dayLabel.rightAnchor)
        ])
    }

    func updateCell(withModel model: CatsResponseModel, index: Int) {
        if let strUrl = model.image?.url {
            let url = URL(string: strUrl)
            image.kf.setImage(with: url,
                             placeholder: UIImage(named: "placeHolderCat"),
                             options: [
                                .transition(ImageTransition.fade(0.5)),
                                .cacheOriginalImage
                                ],
                             progressBlock: nil ,
                             completionHandler: nil)
       } else {
            image.image = UIImage(named: "placeHolderCat")
       }
    
        nameLabel.text = model.name
        dayLabel.text = ("Day \(index + 1)")
    }
}
