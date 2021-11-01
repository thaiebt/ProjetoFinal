//
//  DetailViewController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 25/10/21.
//

import UIKit
import SafariServices
import CoreData

class DetailViewControler: UIViewController {
 
// MARK: Variáveis
    lazy var detailTableCat: UITableView = {
        
        var table = UITableView()
        table.frame = self.view.bounds
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        
        return table
    }()
    
    private let reuseIdentifier = "cell"
    var touchedCat: Cat = Cat()
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(detailTableCat)
        // título da tabela:
        self.title = touchedCat.name
        // Verificando ao carregar quais itens estão salvos no Core Data como favoritos
        verifyFavorite()
    }
}

// MARK: Extensões
extension DetailViewControler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Definição da célula
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // Configuração da célula
        cell.selectionStyle = .none
        // Configurando textos da label de título
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell.textLabel?.textColor = .gray
        // Configurando textos da label de subtítulo
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20.0)
        
        // Configurando os itens que terá cada uma das celulas
        switch indexPath.row {
        case 0:
            return self.setImage()
        case 1:
            return self.setName(cell: cell)
        case 2:
            return self.setDescription(cell: cell)
        case 3:
            return self.setOrigin(cell: cell)
        case 4:
            return self.setLife_Span(cell: cell)
        case 5:
            return self.setTemperament(cell: cell)
        case 6:
            return setWikipedia_Url(cell: cell)
        case 7:
            return self.showFavoriteButton()
        default:
            return UITableViewCell()
        }
        
    }
    
    func setImage() -> UITableViewCell {
        let cellImage = ImageViewCell()
        
        if let urlString = touchedCat.image?.url {
            guard let url = URL(string: urlString) else { return UITableViewCell() }
            cellImage.setImageView(url: url)
        } else {
            cellImage.imageDetailCat.image = UIImage(named: "placeHolderCat")
        }
        return cellImage
    }
    
    func setName(cell: UITableViewCell) -> UITableViewCell {
        guard let name = touchedCat.name else { return UITableViewCell() }
        cell.textLabel?.text = "Name: "
        cell.detailTextLabel?.text = name
        
        return cell
    }
    
    func setDescription(cell: UITableViewCell) -> UITableViewCell {
        guard let description = touchedCat.description else { return UITableViewCell() }
        cell.textLabel?.text = "Description: "
        cell.detailTextLabel?.text = description
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func setOrigin(cell: UITableViewCell) -> UITableViewCell {
        guard let origin = touchedCat.origin else { return UITableViewCell() }
        cell.textLabel?.text = "Origin: "
        cell.detailTextLabel?.text = origin
        
        return cell
    }
    
    func setLife_Span(cell: UITableViewCell) -> UITableViewCell {
        guard let life_span = touchedCat.lifeSpan else { return UITableViewCell() }
        cell.textLabel?.text = "Life expectancy: "
        cell.detailTextLabel?.text = life_span
        
        return cell
    }
    
    func setTemperament(cell: UITableViewCell) -> UITableViewCell {
        guard let temperament = touchedCat.temperament else { return UITableViewCell() }
        cell.textLabel?.text = "Temperament: "
        cell.detailTextLabel?.text = temperament
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func setWikipedia_Url(cell: UITableViewCell) -> UITableViewCell {
        guard let wikipedia_url = touchedCat.wikipediaUrl else { return UITableViewCell() }
        cell.textLabel?.text = "Wikipedia: "
        cell.detailTextLabel?.text = "\(wikipedia_url)"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func setCellAddFavorites() -> UITableViewCell {
       let cell = FavTableViewCell()
        // Definindo imagem
        cell.imageView?.image = UIImage(systemName: "heart.fill")
        cell.imageView?.tintColor = .purple
        // Definindo texto
        cell.textLabel?.text = "Add to favorites"
        
        return cell
    }
    
    func setCellRemoveFavorites() -> UITableViewCell {
        let cell = FavTableViewCell()
         // Definindo imagem
         cell.imageView?.image = UIImage(systemName: "heart.slash.fill")
         cell.imageView?.tintColor = .purple
         // Definindo texto
         cell.textLabel?.text = "Remove to favorites"
         
         return cell
    }

}

extension DetailViewControler: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Definindo seleção da linha do link para a Wikipedia
        if indexPath.row == 6 {
            guard let wikipedia_url = touchedCat.wikipediaUrl else { return }
            guard let url = URL(string: wikipedia_url) else { return }
            
            let safariViewController = SFSafariViewController(url: url)
            
            showDetailViewController(safariViewController, sender: nil)
        }
        print(indexPath.row)
        // Definindo seleção da linha de adicionar ou remover favoritos
        if indexPath.row == 7 {
            if isFavorite {
                removeFavorite()
            } else {
                addFavorites()
            }
        }
    }
    
    func showFavoriteButton() -> UITableViewCell {
        
            if isFavorite {
                return self.setCellRemoveFavorites()
            } else {
                return self.setCellAddFavorites()
            }
    }
    
    func verifyFavorite() {
        
        let context = DataBaseController.persistentContainer.viewContext
        
        do {
            
            guard let catIdentifier = touchedCat.identifier else { return }
            
            let fetchRequest = CatEntity.fetchRequest()
            
            let predicate = NSPredicate(format: "catIdentifier == %@", catIdentifier)
            fetchRequest.predicate = predicate
            
            let favoriteCat = try context.fetch(fetchRequest)
            if favoriteCat.count > 0 {
                isFavorite = true
            } else {
                isFavorite = false
            }
            
        } catch {
            print("Error")
        }
    }

    
    func addFavorites() {
        if let catDescription = touchedCat.description,
           let catIdentifier = touchedCat.identifier,
           let catImage = touchedCat.image?.url,
           let catLife_span = touchedCat.lifeSpan,
           let catName = touchedCat.name,
           let catOrigin = touchedCat.origin,
           let catTemperament = touchedCat.temperament,
           let catWikipedia_url = touchedCat.wikipediaUrl {
            
            let context = DataBaseController.persistentContainer.viewContext
            
            let cat = CatEntity(context: context)
            
            cat.catDescription = catDescription
            cat.catIdentifier = catIdentifier
            cat.catImage = catImage
            cat.catLife_span = catLife_span
            cat.catName = catName
            cat.catOrigin = catOrigin
            cat.catTemperament = catTemperament
            cat.catWikipedia_url = catWikipedia_url
            
            DataBaseController.saveContext()
            
            isFavorite = true
            
            self.detailTableCat.reloadData()
        }
    }
    
    func removeFavorite() {
        guard let catIdentifier = touchedCat.identifier else { return }
        
        let fetchRequest = CatEntity.fetchRequest()
        
        let predicate = NSPredicate(format: "catIdentifier == %@", catIdentifier)
        fetchRequest.predicate = predicate

        fetchRequest.includesPropertyValues = false

        let context = DataBaseController.persistentContainer.viewContext

        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        try? context.save()
        isFavorite = false
        self.detailTableCat.reloadData()
    }
    
   
//Função utilizada apenas para remover todos os itens da CatEntity em dev
//    func removeAllFavorites() {
//        // Create Fetch Request
//        let context = DataBaseController.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatEntity")
//
//        // Create Batch Delete Request
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(batchDeleteRequest)
//
//        } catch {
//            // Error Handling
//        }
//    }

}
