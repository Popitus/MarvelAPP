//
//  ComicsViewModel.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import Combine
import SwiftUI

class ComicsViewModel: ObservableObject {
    
    @Published var status = Status.loading // -> Estado inicial
    @Published var dataHeros: MarvelModel? // -> Modelo de datos de los heroes 
    
    var suscriptor: Set<AnyCancellable> = Set<AnyCancellable>() // -> Suscritor
    
    public init(with comicId: Int) {
        if comicId == 0 {
            self.dataHeros = nil
        } else {
            listadoComicHeroes(with: comicId)
            print("ComicHeroes id: \(comicId)")
        }
    }
    
    func listadoComicHeroes(with filter: Int) {
        
        URLSession.shared
            // Le pasamos la Request creada en BaseNetwork
            .dataTaskPublisher(for: BaseNetwork().getSessionComics(idHero: filter))
            // Comprobar el codigo de respuesta
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse) // Hay un problema en la respuesta
                }
                // Extraemos los datos
                return data
            }
            
            // Decodificamos el data recibido
            .decode(type: MarvelModel.self, decoder: JSONDecoder())
            
            // Ejecutar en el hilo principal
            .receive(on: DispatchQueue.main)
            
            // Controlamos los errores y el valor recibido
            .sink { completion in
                switch completion {
                    case .failure:
                        self.status = Status.error(error: "Hay un error en los datos")
                    case .finished:
                        self.status = Status.loaded
                }
            } receiveValue: { data in
                self.dataHeros = data
            }
            // Lo guardamos en el suscriptor
            .store(in: &suscriptor)
    }
}
