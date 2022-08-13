//
//  ViewController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import UIKit
import Kingfisher
import SnapKit
import AVFoundation

protocol CatListViewProtocol: AnyObject {
    func reloadCollectionView()
    var catList: [CatsResponseModel] { get set }
}

class ViewController: UIViewController, CatListViewProtocol {

    var catList: [CatsResponseModel] = []
    
    private lazy var viewModel: CatListViewModel = {
        let viewModel = CatListViewModel(withProvider: Provider(), view: self)
        return viewModel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let widthCell: CGFloat = (self.view.frame.width*0.95)/2-5
        layout.itemSize = CGSize(width: widthCell, height: widthCell)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CatListCollectionViewCell.self, forCellWithReuseIdentifier: CatListCollectionViewCell.cellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fillCatList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createRightButton()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "One cat a day"
        
        view.addSubview(collectionView)
        makeConstrainCollectionView()
    }
    
    fileprivate func makeConstrainCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func showUserAlert(message: String) {
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.viewModel.fillCatList()
        }
        let goToFavoritesButton = UIAlertAction(title: "Go to favorites", style: .default) { [weak self] _ in
            let favorites = FavoriteViewController()
            self?.navigationController?.pushViewController(favorites, animated: true)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(tryAgain)
        alert.addAction(goToFavoritesButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
 
    func createRightButton() {
        let heartImage = UIImage(systemName: "heart.fill")
        let rightButton = UIBarButtonItem(image: heartImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(getFavorite))
        rightButton.tintColor = .systemPurple
        self.navigationItem.rightBarButtonItem = rightButton
    }

    @objc func getFavorite() {
        let controller = FavoriteViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: Extensões
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatListCollectionViewCell.cellId, for: indexPath) as? CatListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.updateCell(withModel: catList[indexPath.row], index: indexPath.row)
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cat = catList[indexPath.row]
        let controller = DetailViewControler(withModel: cat)
        navigationController?.pushViewController(controller, animated: true)
    }
}
