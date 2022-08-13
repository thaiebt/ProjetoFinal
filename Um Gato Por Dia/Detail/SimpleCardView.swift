//
//  SimpleCardView.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 12/08/22.
//

import UIKit

class SimpleCardView: UIControl {
    
    private lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .top
        stack.isUserInteractionEnabled = false
        stack.spacing = 3
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .gray
        image.contentMode = .center
        return image
    }()
    
    private var action: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addTarget(self, action: #selector(tappedView), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(arrowIcon)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            arrowIcon.heightAnchor.constraint(equalToConstant: 24),
            arrowIcon.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func updateView(title: String, content: String, action: (()->())?) {
        titleLabel.text = title
        contentLabel.text = content
        self.action = action
        if action == nil {
            isUserInteractionEnabled = false
            arrowIcon.isHidden = true
        }
    }
    
    @objc private func tappedView() {
        action?()
    }
}
