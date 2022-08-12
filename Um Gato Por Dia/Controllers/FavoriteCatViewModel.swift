//
//  FavoriteCatViewModel.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 12/08/22.
//

import Foundation

class FavoriteViewModel {
    let apiKey = "dc1f410d-5088-4bb5-bb19-a4f2852b7c27"

    weak var view: FavoriteViewProtocol?
    
    init(view: FavoriteViewProtocol) {
        self.view = view
    }
    
    func bindCatModel(catEntity: CatEntity) -> CatsResponseModel {
        return CatsResponseModel(description: catEntity.description,
                                                     identifier: catEntity.catIdentifier,
                                                     image: ImageCat(url: catEntity.catWikipediaUrl),
                                                     lifeSpan: catEntity.catLifeSpan,
                                                     name: catEntity.catName,
                                                     origin: catEntity.catOrigin,
                                                     temperament: catEntity.catTemperament,
                                                     wikipediaUrl: catEntity.catWikipediaUrl)
    }
    
    func getCatsFromDataBase()  {
        do {
            let cats = try DataBaseController.persistentContainer.viewContext.fetch(CatEntity.fetchRequest())
            view?.favCatList = cats
        } catch {
            print("Não consegui trazer informações do banco de dados!")
        }
        
        view?.reloadTableView()
    }
}
