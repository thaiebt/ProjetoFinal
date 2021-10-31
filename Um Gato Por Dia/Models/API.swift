//
//  API.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

struct API {
    
    let baseUrl = "https://api.thecatapi.com/v1/"
    
    func setBreedURL() -> String {
        return ("\(baseUrl)\(endPoints.breeds)")
    }
    
    func setCategoriesURL() -> String {
        return ("\(baseUrl)\(endPoints.categories)")
    }
    
    
    
    
    func getCats(urlString: String, method: HTTPMethod, key: String, sucess: @escaping ([Cat]) -> Void, errorReturned: @escaping (APIError) -> Void) {
        
        // criar array de Cat
        var arrayCat: [Cat] = []
        
        //MARK: Criando request HTTP
        // criar config da sessao
        let config: URLSessionConfiguration = .default
        
        //construir a sessao
        let session: URLSession = URLSession(configuration: config)
        
        //criar a URL
        guard let url: URL = URL(string: urlString) else {
            return
        }
        
        //URL request
        let urlRequest: URLRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { result, urlResponse, error in
            
            var statusCode: Int = 0
            
            if let response = urlResponse as? HTTPURLResponse {
                statusCode = response.statusCode
                
            }
            
            guard let data = result else {
                errorReturned(APIError.notFound)
                return
            }
            
            do {
                //criar um decoder
                let decoder: JSONDecoder = JSONDecoder()
                
                //decodificar
                let decodeData: [Cat] = try decoder.decode([Cat].self, from: data)
                
                switch statusCode {
                case 200:
                    sucess(decodeData)
                case 404:
                    errorReturned(APIError.notFound)
                case 500:
                    errorReturned(APIError.serverError)
                default:
                    break
                }
                
            } catch {
                errorReturned(APIError.invalidResponse)
            }
        }
        task.resume()
        
    }
    
    
    
}
