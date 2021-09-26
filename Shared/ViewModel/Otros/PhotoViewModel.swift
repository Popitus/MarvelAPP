//
//  PhotoViewModel.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import Combine
import SwiftUI

class PhotoViewModel: ObservableObject {
    
    // Variable para obtener la imagen
    @Published var imagen: Image?
    
    // Creamos el suscriptor
    var suscriptor:Set<AnyCancellable> = Set<AnyCancellable>()
    
    func loadImage(with url:String){
        // TODO: aqui es donde empezamos a realizar el cacheo de imagenes
        let downloadUrl = URL(string: url)! // -> Tenemos la url donde está la imagen
        URLSession.shared
            .dataTaskPublisher(for: downloadUrl)
            .map { response -> UIImage? in
                UIImage(data: response.data)
            }
            .map { image -> Image in
                Image(uiImage: image!)
            }
            .replaceError(with: Image(systemName: "person.fill"))
            .replaceNil(with: Image(systemName: "person.fill"))
            .receive(on: DispatchQueue.main)
            .sink { imagenFInal in
                self.imagen = imagenFInal
            }
            .store(in: &suscriptor)
        
        
        
        
    }
}
