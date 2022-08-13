//
//  Cats.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

struct CatsResponseModel: Decodable {
    let description: String?
    let identifier: String?
    let image: ImageCat?
    let lifeSpan: String?
    let name: String?
    let origin: String?
    let temperament: String?
    let wikipediaUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case description
        case identifier = "id"
        case image
        case lifeSpan = "life_span"
        case name
        case origin
        case temperament
        case wikipediaUrl = "wikipedia_url"
    }
}

struct ImageCat: Decodable {
    let url: String?
}
