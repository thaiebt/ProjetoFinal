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
    func reloadTableView()
}

class DetailViewControler: UIViewController, DetailViewProtocol {
    
    private lazy var viewModel: DetailViewModel = {
        let viewModel = DetailViewModel(withCat: catModel, view: self)
        return viewModel
    }()
 
    private lazy var tableView: UITableView = {
        var table = UITableView()
        table.frame = view.bounds
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    private let reuseIdentifier = "cell"
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
        view.addSubview(tableView)
        title = catModel.name
        viewModel.checkFavoriteCat()
    }
    
    func reloadTableView() {
        tableView.reloadData()
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
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell.textLabel?.textColor = .gray
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20.0)

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
        
        if let urlString = catModel.image?.url {
            guard let url = URL(string: urlString) else { return UITableViewCell() }
            cellImage.setImageView(url: url)
        } else {
            cellImage.imageDetailCat.image = UIImage(named: "placeHolderCat")
        }
        return cellImage
    }
    
    func setName(cell: UITableViewCell) -> UITableViewCell {
        guard let name = catModel.name else { return UITableViewCell() }
        cell.textLabel?.text = "Name: "
        cell.detailTextLabel?.text = name
        
        return cell
    }
    
    func setDescription(cell: UITableViewCell) -> UITableViewCell {
        guard let description = catModel.description else { return UITableViewCell() }
        cell.textLabel?.text = "Description: "
        cell.detailTextLabel?.text = description
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func setOrigin(cell: UITableViewCell) -> UITableViewCell {
        guard let origin = catModel.origin else { return UITableViewCell() }
        cell.textLabel?.text = "Origin: "
        cell.detailTextLabel?.text = origin
        
        return cell
    }
    
    func setLife_Span(cell: UITableViewCell) -> UITableViewCell {
        guard let life_span = catModel.lifeSpan else { return UITableViewCell() }
        cell.textLabel?.text = "Life expectancy: "
        cell.detailTextLabel?.text = life_span
        
        return cell
    }
    
    func setTemperament(cell: UITableViewCell) -> UITableViewCell {
        guard let temperament = catModel.temperament else { return UITableViewCell() }
        cell.textLabel?.text = "Temperament: "
        cell.detailTextLabel?.text = temperament
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    func setWikipedia_Url(cell: UITableViewCell) -> UITableViewCell {
        guard let wikipedia_url = catModel.wikipediaUrl else { return UITableViewCell() }
        cell.textLabel?.text = "Wikipedia: "
        cell.detailTextLabel?.text = "\(wikipedia_url)"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15.0)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func showFavoriteButton() -> UITableViewCell {
            if isFavorite {
                return self.setCellRemoveFavorites()
            } else {
                return self.setCellAddFavorites()
            }
    }
    
    func showFavoriteButton() -> UITableViewCell {
            if isFavorite {
                return self.setCellRemoveFavorites()
            } else {
                return self.setCellAddFavorites()
            }
    }
    
    func setCellAddFavorites() -> UITableViewCell {
       let cell = FavTableViewCell()
        // Definindo imagem
        cell.imageView?.image = UIImage(systemName: "heart")
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
         cell.textLabel?.text = "Remove from favorites"
         
         return cell
    }
}

extension DetailViewControler: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Definindo seleção da linha do link para a Wikipedia
        if indexPath.row == 6 {
            guard let wikipedia_url = catModel.wikipediaUrl else { return }
            guard let url = URL(string: wikipedia_url) else { return }
            
            let safariViewController = SFSafariViewController(url: url)
            
            showDetailViewController(safariViewController, sender: nil)
        }
        print(indexPath.row)
        // Definindo seleção da linha de adicionar ou remover favoritos
        if indexPath.row == 7 {
            if isFavorite {
                viewModel.removeFavoriteCat()
            } else {
                viewModel.addFavorite()
            }
        }
    }
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
