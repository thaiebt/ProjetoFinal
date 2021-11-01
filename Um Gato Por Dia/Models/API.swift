//
//  API.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

class API {
    
    let baseUrl = "https://api.thecatapi.com/v1/"
    
    func setBreedURL() -> String {
        return ("\(baseUrl)\(EndPoints.breeds)")
    }
    
    func setCategoriesURL() -> String {
        return ("\(baseUrl)\(EndPoints.categories)")
    }
    
    
    
    
    func getCats(urlString: String, method: HTTPMethod, key: String, sucess: @escaping ([Cat]) -> Void, errorReturned: @escaping (APIError) -> Void) {
        
        // criar array de Cat
        var _: [Cat] = []
        
        // Criando request HTTP
        // Criando config da sessão
        let config: URLSessionConfiguration = .default
        
        // Contruindo a sessão
        let session: URLSession = URLSession(configuration: config)
        
        // Criando a URL
        guard let url: URL = URL(string: urlString) else {
            return
        }
        
        // URL request
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
                // Criando um decoder
                let decoder: JSONDecoder = JSONDecoder()
                // Decodificar
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
