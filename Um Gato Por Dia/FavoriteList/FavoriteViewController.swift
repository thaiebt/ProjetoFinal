//
//  FavoritesViewController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 27/10/21.
//

import UIKit
import Kingfisher

protocol FavoriteViewProtocol: AnyObject {
    func reloadTableView()
    var favCatList: [CatEntity] { get set }
}

class FavoriteViewController: UIViewController, FavoriteViewProtocol {

    private lazy var viewModel: FavoriteViewModel = {
        let viewModel = FavoriteViewModel(view: self)
        return viewModel
    }()
    
    var favCatList: [CatEntity] = []
    
    private lazy var favoriteTableView: UITableView = {
        let table = UITableView()
        table.frame = self.view.bounds
        table.delegate = self
        table.dataSource = self
        table.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.idCell)
        return table
    }()
    
    private lazy var noDataLabel: UILabel = {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: favoriteTableView.bounds.size.width, height: favoriteTableView.bounds.size.height))
        label.text = "No cats saved as favorites"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCatsFromDataBase()
    }
    
    private func setupLayout() {
        view.addSubview(favoriteTableView)
        title = "Favorites"
    }

    func reloadTableView() {
        favoriteTableView.reloadData()
    }
}

//MARK: Extension
extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if favCatList.count > 0 {
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCatList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.idCell, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        let cat = favCatList[indexPath.row]
        cell.updateCell(withCatEntity: cat)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favCat = favCatList[indexPath.row]
        let selectedCat = viewModel.bindCatModel(catEntity: favCat)
        
        let controller = DetailViewControler(withModel: selectedCat)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
}
