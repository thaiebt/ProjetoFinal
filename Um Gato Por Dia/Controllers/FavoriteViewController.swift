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
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        // Definindo número de sessões e mensagem quando o número de sessões for zero
        if self.favoriteCat.count > 0 {
                numOfSections = 1
                tableView.backgroundView = nil
            } else {
                let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                noDataLabel.text = "No cats saved as favorites"
                noDataLabel.textColor = .darkGray
                noDataLabel.font = UIFont.boldSystemFont(ofSize: 15)
                noDataLabel.textAlignment = .center
                tableView.backgroundView = noDataLabel
                tableView.separatorStyle = .none
            }
            return numOfSections
    }
    
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
        cell?.imageCatFavTable.layer.cornerRadius = 55
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
        newTouchedCat.lifeSpan = favCatEntity.catLifeSpan
        newTouchedCat.name = favCatEntity.catName
        newTouchedCat.origin = favCatEntity.catOrigin
        newTouchedCat.temperament = favCatEntity.catTemperament
        newTouchedCat.wikipediaUrl = favCatEntity.catWikipediaUrl
        
        detail.touchedCat = newTouchedCat
        
        self.show(detail, sender: self)
    }
}
