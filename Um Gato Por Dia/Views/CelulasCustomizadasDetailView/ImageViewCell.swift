//
//  ImageViewCell.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 26/10/21.
//

import UIKit

class ImageViewCell: UITableViewCell {
    
    var imageDetailCat = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.imageDetailCat)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageView(url: URL) {
        self.imageDetailCat.contentMode = .scaleAspectFit
        self.imageDetailCat.kf.setImage(with: url,
                                    options: [
                                        .cacheOriginalImage
                                    ],
                                    completionHandler: nil)
        
        self.imageDetailCat.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(self).offset(-15)
            make.height.equalTo(300)
        }
    }
}
