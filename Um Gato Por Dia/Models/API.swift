//
//  API.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

class API: CatApi {
    
    let baseUrl = "https://api.thecatapi.com/v1/"
    
    func setBreedURL() -> String {
        return ("\(baseUrl)\(EndPoints.breeds)")
    }
      
    func getCats(urlString: String, method: HTTPMethod, key: String, completion: @escaping (Result<[Cat], APIError>) -> Void) {

        // Criando array de Cat
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
                print(statusCode)
            }

            guard let data = result else {
                completion(Result.failure(APIError.emptyData))
                return
            }

            do {
                // Criando um decoder
                let decoder: JSONDecoder = JSONDecoder()
                // Decodificar
                let decodeData: [Cat] = try decoder.decode([Cat].self, from: data)

                switch statusCode {
                case 200:
                    completion(Result.success(decodeData))
                case 404:
                    completion(Result.failure(APIError.notFound))
                case 500:
                    completion(Result.failure(APIError.serverError))
                default:
                    break
                }
            } catch {
                completion(Result.failure(APIError.invalidData))
            }
        }
        task.resume()
    }
}
