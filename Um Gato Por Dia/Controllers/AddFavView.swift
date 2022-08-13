//
//  AddFavView.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 12/08/22.
//

import UIKit

protocol AddFavViewClickDelegate: AnyObject {
    func didTapAddFavView()
}
 
class AddFavView: UIControl {
    
    private lazy var viewIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.tintColor = .systemPurple
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    weak var clickDelegate: AddFavViewClickDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(viewIcon)
        addSubview(titleLabel)
        addTarget(self, action: #selector(tappedView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            viewIcon.heightAnchor.constraint(equalToConstant: 24),
            viewIcon.widthAnchor.constraint(equalToConstant: 24),
            viewIcon.topAnchor.constraint(equalTo: topAnchor),
            viewIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            viewIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: viewIcon.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: viewIcon.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
    
    func updateView(icon: UIImage?, iconColor: UIColor, title: String)  {
        viewIcon.image = icon
        viewIcon.tintColor = iconColor
        titleLabel.text = title
    }
    
    @objc private func tappedView() {
        clickDelegate?.didTapAddFavView()
    }
    
}
