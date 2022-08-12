//
//  API.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

protocol ProviderProtocol {
    func setBreedURL() -> String
    func makeRequest<Success: Decodable>(url: String, completion: @escaping (Result<[Success], APIError>) -> Void)
}

class Provider: ProviderProtocol {
    
    private let baseUrl = "https://api.thecatapi.com/v1/"
    private var statusCode: Int = 0
    
    func setBreedURL() -> String {
        return ("\(baseUrl)\(EndPoints.breeds)")
    }
    
    func makeRequest<Success: Decodable>(url: String, completion: @escaping (Result<[Success], APIError>) -> Void)  {
        if let url = URL(string: url) {
            let config: URLSessionConfiguration = .default
            let session: URLSession = URLSession(configuration: config)
            
            let task = session.dataTask(with: url) { data, response, error in
                if let response = response as? HTTPURLResponse {
                    self.statusCode = response.statusCode
                    print(self.statusCode)
                }
                
                if let data = data {
                    do {
                        let decoder: JSONDecoder = JSONDecoder()
                        let decodeData = try decoder.decode([Success].self, from: data)
                        
                            completion(Result.success(decodeData))
                        
                    }catch {
                    
                            completion(Result.failure(APIError.invalidData))
                        
                    }
                }
            }
            task.resume()
        }
    }
}
