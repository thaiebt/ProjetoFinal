//
//  ImageCat.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 21/10/21.
//

import Foundation

struct ImageCat: Codable {
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}
