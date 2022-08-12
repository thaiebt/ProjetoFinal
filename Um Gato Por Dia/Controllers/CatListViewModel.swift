//
//  CatListViewModel.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 12/08/22.
//

import Foundation

class CatListViewModel {
    weak var view: CatListViewProtocol?
    let provider: ProviderProtocol
    init(withProvider provider: ProviderProtocol, view: CatListViewProtocol) {
        self.provider = provider
        self.view = view
    }
    
    func fillCatList() {
        getCats { [weak self] result in
            switch result {
            case .success(let cats):
                self?.view?.catList = cats
                self?.view?.reloadCollectionView()
            case .failure(let error):
                switch error {
                case .emptyReponse:
                    print("Empty Response")
                case .notFound:
                    print("Not Found")
                case .emptyData:
                    print("Empty Data")
                case .serverError:
                    print("Server Error")
                case .invalidData:
                    print("Invalid Data")
                }
            }
        }
    }
    
    private func getCats(completion: @escaping (Result<[CatsResponseModel], APIError>) -> Void) {
        provider.makeRequest(url: provider.setBreedURL()) { (response: Result<[CatsResponseModel], APIError>) in
            DispatchQueue.main.async {
                completion(response)
            }
            
        }
    }
}
