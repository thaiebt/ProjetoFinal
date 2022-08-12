//
//  DetailViewModel.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 12/08/22.
//

import Foundation

class DetailViewModel {
    let cat: CatsResponseModel
    weak var view: DetailViewProtocol?
    
    init(withCat cat: CatsResponseModel, view: DetailViewProtocol) {
        self.view = view
        self.cat = cat
    }
    
    func checkFavoriteCat() {
        view?.isFavorite = DataBaseController.verifyFavorite(cat: cat)
        view?.reloadTableView()
    }
    
    func removeFavoriteCat() {
        DataBaseController.removeFavorite(cat: cat)
        view?.isFavorite = false
        view?.reloadTableView()
    }
    
    func addFavorite() {
        DataBaseController.addFavorites(catModel: cat)
        view?.isFavorite = true
        view?.reloadTableView()
    }
}
