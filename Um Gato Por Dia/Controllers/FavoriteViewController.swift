//
//  FavoritesViewController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 27/10/21.
//

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController {
    
    var favoriteCat: [CatEntity] = []
    var reuseIdentifier = "favCell"
    
    lazy var favoriteTableCat: UITableView = {
        let favTable = UITableView()
        favTable.frame = self.view.bounds
        favTable.delegate = self
        favTable.dataSource = self
        return favTable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(self.favoriteTableCat)
        
        let nibFavCell = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        favoriteTableCat.register(nibFavCell, forCellReuseIdentifier: FavoriteTableViewCell.idCelulaFavTableView)
        
        self.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableViewAddFavorites()
    }
    
    // MARK: Métodos
    
    func reloadTableViewAddFavorites() {
        do {
            self.favoriteCat = try DataBaseController.persistentContainer.viewContext.fetch(CatEntity.fetchRequest())
        } catch {
            print("Não consegui trazer informações do banco de dados!")
        }
        self.favoriteTableCat.reloadData()
    }

}

//MARK: Extensões

extension FavoriteViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.favoriteCat.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.idCelulaFavTableView, for: indexPath) as? FavoriteTableViewCell
        
        let favCat = favoriteCat[indexPath.row]
        
        cell?.accessoryType = .disclosureIndicator
        // Configurando label título
        cell?.labelNameCatFavTable.text = favCat.catName
        cell?.labelNameCatFavTable.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell?.labelNameCatFavTable.textColor = .darkGray
        // Configurando label subtítulo
        cell?.labelDescriptionFavTable.text = favCat.catDescription
        cell?.labelDescriptionFavTable.numberOfLines = 0
        cell?.labelDescriptionFavTable.font = UIFont.systemFont(ofSize: 15.0)
        // Configurando imagem
        if let image = favCat.catImage {
            let url = URL(string: image)
            cell?.imageCatFavTable.kf.setImage(with: url, placeholder: UIImage(named: "placeHolderCat"), options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        } else {
            cell?.imageCatFavTable.image = UIImage(named: "placeHolderCat")
        }
        cell?.imageCatFavTable.layer.cornerRadius = 65
        cell?.imageCatFavTable.layer.masksToBounds = true
        cell?.imageCatFavTable.contentMode = .scaleAspectFill
        
        return cell!
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewControler()
        
        let favCatEntity = favoriteCat[indexPath.row]
        
        let imageCat = ImageCat()
        imageCat.url = favCatEntity.catImage
        
        let newTouchedCat: Cat = Cat()
        newTouchedCat.description = favCatEntity.catDescription
        newTouchedCat.identifier = favCatEntity.catIdentifier
        newTouchedCat.image = imageCat
        newTouchedCat.lifeSpan = favCatEntity.catLife_span
        newTouchedCat.name = favCatEntity.catName
        newTouchedCat.origin = favCatEntity.catOrigin
        newTouchedCat.temperament = favCatEntity.catTemperament
        newTouchedCat.wikipediaUrl = favCatEntity.catWikipedia_url
        
        detail.touchedCat = newTouchedCat
        
        self.show(detail, sender: self)
    }
}
