//
//  FavoritesViewController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 27/10/21.
//

import UIKit

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
        
        reloadTableViewFavorites()
    }
    
    func reloadTableViewFavorites() {
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
        
        cell?.labelNameCatFavTable.text = favCat.catName
        cell?.labelDescriptionFavTable.text = favCat.catDescription
        cell?.labelDescriptionFavTable.numberOfLines = 0
        
        if let image = favCat.catImage {
            guard let url = URL(string: image) else { return UITableViewCell() }
                let data = try? Data(contentsOf: url)
                cell?.imageCatFavTable.image = UIImage(data: data!)
        } else {
            cell?.imageCatFavTable.image = UIImage(named: "placeHolderCat")
        }
        
        return cell!
    }


}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewControler()
        
        let favCatEntity = favoriteCat[indexPath.row]
        
        var imageCat = ImageCat()
        imageCat.url = favCatEntity.catImage
        
        var newTouchedCat: Cat = Cat()
        newTouchedCat.description = favCatEntity.catDescription
        newTouchedCat.identifier = favCatEntity.catIdentifier
        newTouchedCat.image = imageCat
        newTouchedCat.life_span = favCatEntity.catLife_span
        newTouchedCat.name = favCatEntity.catName
        newTouchedCat.origin = favCatEntity.catOrigin
        newTouchedCat.temperament = favCatEntity.catTemperament
        newTouchedCat.wikipedia_url = favCatEntity.catWikipedia_url
        
        detail.touchedCat = newTouchedCat
        
        self.show(detail, sender: nil)
    }
}
