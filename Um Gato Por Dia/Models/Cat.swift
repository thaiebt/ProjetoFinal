//
//  Cats.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

class Cat: Codable {
    var description: String?
    var identifier: String?
    var image: ImageCat?
    var lifeSpan: String?
    var name: String?
    var origin: String?
    var temperament: String?
    var wikipediaUrl: String?
    
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
    
    init(description: String? = nil,
        identifier: String? = nil,
        image: ImageCat? = nil,
        lifeSpan: String? = nil,
        name: String? = nil,
        origin: String? = nil,
        temperament: String? = nil,
        wikipediaUrl: String? = nil
    
    ) {
        self.description = description
        self.identifier = identifier
        self.image = image
        self.lifeSpan = lifeSpan
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.wikipediaUrl = wikipediaUrl
    }
}
