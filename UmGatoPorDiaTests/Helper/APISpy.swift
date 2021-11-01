//
//  APISpy.swift
//  UmGatoPorDiaTests
//
//  Created by Thaina da Silva Ebert on 01/11/21.
//

import XCTest
@testable import Um_Gato_Por_Dia

// Criando um duble de testes
class APISpy: CatApi {
    
    var apiCalls = 0
    
    func setBreedURL() -> String {
        return ""
    }
    
    func getCats(urlString: String, method: HTTPMethod, key: String, completion: @escaping (Result<[Cat], APIError>) -> Void) {
        apiCalls += 1
    }
   
}
