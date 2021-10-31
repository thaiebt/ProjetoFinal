//
//  ViewController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import UIKit
import Kingfisher
import SnapKit

class ViewController: UIViewController {
    
    //MARK: Váriáveis
    
    var arrayCat: [Cat] = []
    let api = API()
    let apiKey = "dc1f410d-5088-4bb5-bb19-a4f2852b7c27"
    let day = "Day "
    
    // Criando a ColletionView
    lazy var catsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let larguraCelula: CGFloat = (self.view.frame.width*0.95)/2-5
        layout.itemSize = CGSize(width: larguraCelula, height: larguraCelula)
        
        //espaço entre os elementos
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.showsHorizontalScrollIndicator = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        //collectionView.backgroundColor = .clear
        
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(catsCollectionView)
        
        makeConstrainCollectionView()
        
        //Registrando celula customizada collection
        let nibCell = UINib(nibName: "CelulaCatsCustomizadaCollectionViewCell", bundle: nil)
        catsCollectionView.register(nibCell, forCellWithReuseIdentifier: CelulaCatsCustomizadaCollectionViewCell.idCelulaCollectionView)
        
        self.view.backgroundColor = .white
        
        self.populaArrayCat()
        
        self.title = "One cat a day"
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.createRightButton()
    }
    
    //MARK: Métodos
    
    // Criandro a função que adiciona constrains na Collection
    fileprivate func makeConstrainCollectionView() {
        NSLayoutConstraint.activate([
            //catsCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            catsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            catsCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            catsCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            catsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    //Criando a função que busca na API os itens e popula o array
    func populaArrayCat() {
        api.getCats(urlString: api.setBreedURL(), method: .GET, key: apiKey) { cat in
            DispatchQueue.main.async {
                self.arrayCat = cat
                self.catsCollectionView.reloadData()
            }
        } errorReturned: { error in
            switch error {
            case .emptyReponse:
                self.showUserAlert(message: "The array is empty")
            case .notFound:
                self.showUserAlert(message: "No internet access")
            default:
                break;
            }
        }

    }
    
    func showUserAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
            
            let buttonRedoCallApi = UIAlertAction(title: "Try again", style: .default) { _ in
                self.populaArrayCat()
            }
            
            let buttonGoToFavorite = UIAlertAction(title: "Go to favorites", style: .default) { _ in
                let favorites = FavoriteViewController()
                self.navigationController?.pushViewController(favorites, animated: true)
            }
            
            let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(buttonRedoCallApi)
            alert.addAction(buttonGoToFavorite)
            alert.addAction(buttonCancel)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //Função para criar botão de acesso aos favoritos
    func createRightButton() {
        let heartImage = UIImage(systemName: "heart.fill")
        
        let rightButton = UIBarButtonItem(image: heartImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(getFavorite))
        
        rightButton.tintColor = .systemPurple
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @objc func getFavorite() {
        let favViewController = FavoriteViewController()
        self.show(favViewController, sender: nil)
    }
    

}

    //MARK: Extensões

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayCat.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CelulaCatsCustomizadaCollectionViewCell.idCelulaCollectionView, for: indexPath) as? CelulaCatsCustomizadaCollectionViewCell
        
        // Configuração da imagem usando o Framework KingFisher
        if let image = self.arrayCat[indexPath.row].image?.url {
            let url = URL(string: image)
            
            cell?.imageCatCollectionView.kf.setImage(with: url,
                                                     placeholder: UIImage(named: "placeHolderCat"),
                                                     options: [
                                                        .transition(ImageTransition.fade(0.5)),
                                                        .cacheOriginalImage
                                                        ],
                                                     progressBlock: nil ,
                                                     completionHandler: nil)
        } else {
            cell?.imageCatCollectionView.image = UIImage(named: "placeHolderCat")
        }
        
        cell?.imageCatCollectionView.contentMode = .scaleAspectFill
        cell?.layer.cornerRadius = 15
        
        cell?.nameCatCollectionView.text = self.arrayCat[indexPath.row].name
        cell?.nameCatCollectionView.textColor = .white
        cell?.nameCatCollectionView.textAlignment = .center
        
        cell?.labelDay.text = ("Day \(indexPath.row + 1)")
        cell?.labelDay.textColor = .white
        cell?.labelDay.textAlignment = .center
        cell?.labelDay.font = UIFont.boldSystemFont(ofSize: 25.0)
        
        
        
        return cell!
    }
    
    
    
}


extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detail = DetailViewControler()
        
        detail.touchedCat = self.arrayCat[indexPath.row]
        
        self.show(detail, sender: nil)
        
    }
    
}
