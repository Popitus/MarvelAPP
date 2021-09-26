//
//  HeroViewModel.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import Combine
import SwiftUI

class HerosViewModel: ObservableObject {
    
    @Published var cajaBusqueda: String = ""
    
    @Published var status = Status.none // -> Estado inicial
    @Published var dataHeros: [Result]? = nil // -> Modelo de datos de los heroes
    
    var suscriptor: Set<AnyCancellable> = Set<AnyCancellable>() // -> Suscritor
    
    init(comprobar: Bool) {
        if comprobar == true{
            print("dentro de comprobar, comprobar es verdadero")
            $cajaBusqueda
                .removeDuplicates()
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .sink { cadena in
                    if cadena == "" {
                        self.dataHeros = nil
                    } else {
                        print(self.cajaBusqueda)
                        self.listadoSuperHeroes(with: self.cajaBusqueda)
                    }
                }
                .store(in: &suscriptor)
        } else {
            print("Dentro de comprobar, comprobar es falso")
            self.listadoSuperHeroesVacio()
        }
        
    }
    
    func listadoSuperHeroes(with filter: String = "") {
        
        self.status = Status.loading
        
        URLSession.shared
            // Le pasamos la Request creada en BaseNetwork
            .dataTaskPublisher(for: BaseNetwork().getSessionSuperHeroesName(filter: filter))
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
                self.dataHeros = data.data.results
            }
            // Lo guardamos en el suscriptor
            .store(in: &suscriptor)
    }
    
    func listadoSuperHeroesVacio(with filter: String = "") {
        
        self.status = Status.loading
        
        URLSession.shared
            // Le pasamos la Request creada en BaseNetwork
            .dataTaskPublisher(for: BaseNetwork().getSessionSuperHeroes(filter: filter))
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
                self.dataHeros = data.data.results
            }
            // Lo guardamos en el suscriptor
            .store(in: &suscriptor)
    }
    
}
