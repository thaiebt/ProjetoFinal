//
//  APIError.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 27/10/21.
//

import Foundation

enum APIError: Error {
    case emptyReponse
    case notFound
    case emptyArray
    case serverError
    case invalidResponse
}
