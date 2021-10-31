//
//  Cats.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

//{
//  "adaptability": 5,
//  "affection_level": 5,
//  "alt_names": "",
//  "cfa_url": "http://cfa.org/Breeds/BreedsAB/Abyssinian.aspx",
//  "child_friendly": 3,
//  "country_code": "EG",
//  "country_codes": "EG",
//  "description": "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.",
//  "dog_friendly": 4,
//  "energy_level": 5,
//  "experimental": 0,
//  "grooming": 1,
//  "hairless": 0,
//  "health_issues": 2,
//  "hypoallergenic": 0,
//  "id": "abys",
//  "image": {
//    "height": 1445,
//    "id": "0XYvRd7oD",
//    "url": "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg",
//    "width": 1204
//  },
//  "indoor": 0,
//  "intelligence": 5,
//  "lap": 1,
//  "life_span": "14 - 15",
//  "name": "Abyssinian",
//  "natural": 1,
//  "origin": "Egypt",
//  "rare": 0,
//  "reference_image_id": "0XYvRd7oD",
//  "rex": 0,
//  "shedding_level": 2,
//  "short_legs": 0,
//  "social_needs": 5,
//  "stranger_friendly": 5,
//  "suppressed_tail": 0,
//  "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
//  "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
//  "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
//  "vocalisation": 1,
//  "weight": {
//    "imperial": "7  -  10",
//    "metric": "3 - 5"
//  },
//  "wikipedia_url": "https://en.wikipedia.org/wiki/Abyssinian_(cat)"
//},


class Cat: Codable {
    var description: String?
    var identifier: String?
    var image: ImageCat?
    var life_span: String?
    var name: String?
    var origin: String?
    var temperament: String?
    var wikipedia_url: String?
    
    enum CodingKeys: String, CodingKey {
        case description
        case identifier = "id"
        case image
        case life_span
        case name
        case origin
        case temperament
        case wikipedia_url
        
    }
    
    init(description: String? = nil,
        identifier: String? = nil,
        image: ImageCat? = nil,
        life_span: String? = nil,
        name: String? = nil,
        origin: String? = nil,
        temperament: String? = nil,
        wikipedia_url: String? = nil
    
    ) {
        self.description = description
        self.identifier = identifier
        self.image = image
        self.life_span = life_span
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.wikipedia_url = wikipedia_url
    }    
    
}
