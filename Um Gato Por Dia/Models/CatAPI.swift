//
//  CatAPI.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 01/11/21.
//

import Foundation

// Criação do protocolo para padronizar criação da API
protocol CatApi {
    
    func setBreedURL() -> String
    
    func getCats(urlString: String, method: HTTPMethod, key: String, completion: @escaping (Result<[Cat], APIError>) -> Void)
}
