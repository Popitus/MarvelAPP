//
//  MarvelModel.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import Foundation

struct MarvelModel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataMarvel
}

struct DataMarvel: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

struct Result: Codable, Identifiable {
    let id: Int
    let title: String? // -> Opcional para Comics
    let name: String? // -> Opcional para heroes
    let description: String? // -> Puede o no venir vacio	
    let thumbnail: Thumbnail
    let resourceURI: String? // -> Puede venir o no.
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    // Funcion para la imagen y que devuelva la dirección completa
    func getUrlThumbnail() -> String {
        return "\(path).\(thumbnailExtension)"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
}

enum Status {
    case none
    case loading
    case loaded
    case error(error: String)
}
 
 
