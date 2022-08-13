//
//  DetailViewController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 25/10/21.
//

import UIKit
import SafariServices
import CoreData

protocol DetailViewProtocol: AnyObject {
    var isFavorite: Bool { get set }
    func updateFavoriteView()
}

class DetailViewControler: UIViewController, DetailViewProtocol {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16
        return stack
    }()
    
    private lazy var catImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameView: SimpleCardView = {
        let view = SimpleCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionView: SimpleCardView = {
        let view = SimpleCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var originView: SimpleCardView = {
        let view = SimpleCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lifeSpanView: SimpleCardView = {
        let view = SimpleCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var temperamentView: SimpleCardView = {
        let view = SimpleCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var wikipediaView: SimpleCardView = {
        let view = SimpleCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewModel: DetailViewModel = {
        let viewModel = DetailViewModel(withCat: catModel, view: self)
        return viewModel
    }()
    
    private lazy var favoriteView: AddFavView = {
        let view = AddFavView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clickDelegate = self
        return view
    }()
    
    private let catModel: CatsResponseModel
    var isFavorite: Bool = false
    
    init(withModel model: CatsResponseModel) {
        catModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.checkFavoriteCat()
        updateView()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        scrollView.addSubview(catImage)
        mainStackView.addArrangedSubview(nameView)
        mainStackView.addArrangedSubview(descriptionView)
        mainStackView.addArrangedSubview(originView)
        mainStackView.addArrangedSubview(lifeSpanView)
        mainStackView.addArrangedSubview(temperamentView)
        mainStackView.addArrangedSubview(wikipediaView)
        mainStackView.addArrangedSubview(favoriteView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            catImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            catImage.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            catImage.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            catImage.heightAnchor.constraint(lessThanOrEqualToConstant: 350),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: catImage.bottomAnchor, constant: 16),
            mainStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            
        ])
    }
    
    private func updateView() {
        guard let strUrl = catModel.image?.url, let url = URL(string: strUrl) else {
            catImage.image = UIImage(named: "placeHolderCat")
            return
        }
        
        catImage.load(url: url)
        nameView.updateView(title: "Name: ", content: catModel.name ?? "", action: nil)
        descriptionView.updateView(title: "Description: ", content: catModel.description ?? "", action: nil)
        originView.updateView(title: "Origin: ", content: catModel.origin ?? "", action: nil)
        lifeSpanView.updateView(title: "Life expectancy: ", content: catModel.lifeSpan ?? "", action: nil)
        temperamentView.updateView(title: "Temperament: ", content: catModel.temperament ?? "", action: nil)
        wikipediaView.updateView(title: "Wikipedia: ", content: catModel.wikipediaUrl ?? "") {
            guard let wikipedia_url = self.catModel.wikipediaUrl,
                  let url = URL(string: wikipedia_url) else { return }
            
            let safariViewController = SFSafariViewController(url: url)
            self.showDetailViewController(safariViewController, sender: nil)
        }
        view.layoutIfNeeded()
    }
    
    func updateFavoriteView() {
        if isFavorite {
            favoriteView.updateView(icon: UIImage(systemName: "heart.slash.fill"), iconColor: .purple, title: "Remove from favorites")
            return
        }
        favoriteView.updateView(icon: UIImage(systemName: "heart"), iconColor: .purple, title: "Add to favorites")
    }
}

//MARK: FavoriteView delegate
extension DetailViewControler: AddFavViewClickDelegate {
    func didTapAddFavView() {
        print("cliqueiiiii")
        if isFavorite {
            viewModel.removeFavoriteCat()
            return
        }
        viewModel.addFavorite()
    }
}
