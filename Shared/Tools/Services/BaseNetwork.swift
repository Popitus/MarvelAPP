//
//  BaseNetwork.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import Foundation

let server = "https://gateway.marvel.com"
let privateKey: String = "4315c17d3f33858e1a4a365918645b81e8d89713"
let publicKey: String = "32f3d53e5d1e65e905d4bc9545ef9362"
let hashe: String = "32268169684d1cbbb0607159e5fe4faa"
let ts = "1"

enum endPoints: String {
    case characters = "/v1/public/characters?nameStartsWith="
    case comics = "/v1/public/characters"
}

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let content = "application/json"
}

struct BaseNetwork {
    // Recordar que private es solo para este archivo
    private func getURLCharacter(endpoint: String, subPath: String="") -> String {
        let cambioEspacios: String
        print(subPath)
        if subPath.contains(" ") {
            cambioEspacios = subPath.replacingOccurrences(of: " ", with: "%20")
        } else {
            cambioEspacios = subPath
        }
        return "\(server)\(endpoint)\(cambioEspacios)&apikey=\(publicKey)&ts=\(ts)&hash=\(hashe)"
    }
    
    private func getURLComic(endpoint: String, subPath: String="") -> String {
        let cambioEspacios: String
        print(subPath)
        if subPath.contains(" ") {
            cambioEspacios = subPath.replacingOccurrences(of: " ", with: "%20")
        } else {
            cambioEspacios = subPath
        }
        return "\(server)\(endpoint)\(cambioEspacios)?apikey=\(publicKey)&ts=\(ts)&hash=\(hashe)"
    }
    
    // Hacemos la llamada para recoger los nombres de los superheroes inicial
    func getSessionSuperHeroes(filter: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: getURLComic(endpoint: endPoints.comics.rawValue, subPath: filter))!) // -> Recordar que rawValue, coge lo de dentro de las comillas
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        print("request: \(request)")
        return request
    }
    
    // Hacemos la llamada para recoger los nombres de los superheroes
    func getSessionSuperHeroesName(filter: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: getURLCharacter(endpoint: endPoints.characters.rawValue, subPath: filter))!) // -> Recordar que rawValue, coge lo de dentro de las comillas
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        print("request: \(request)")
        return request
    }
    
    // Hacemos la llamada para recoger los comics en referencia al superheroe elegido
    func getSessionComics(idHero: Int) -> URLRequest {
        var request: URLRequest = URLRequest(url: URL(string: getURLComic(endpoint: endPoints.comics.rawValue, subPath: "/\(idHero)/series"))!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        print("request: \(request)")
        return request
    }
    
}
