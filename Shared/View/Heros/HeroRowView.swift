//
//  HeroRowView.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import SwiftUI

struct HeroRowView: View {
    
    var hero: Result // Nos lo pasa la vista HerosListView
    
    @StateObject private var viewModel: PhotoViewModel = PhotoViewModel()
    
    var body: some View {
        HStack{
            // Foto del heroe
            if let photo = viewModel.imagen {
                photo
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150, alignment: .center)
                    .cornerRadius(10)
                    .padding([.leading,.trailing], 4)
                
            } else {
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .leading)
                    .cornerRadius(10)
                    .padding([.leading,.trailing], 20)
                    .opacity(0.6)
            }
            // Hay que comprobar el optional.. ¿Como?
            VStack(alignment: .leading, spacing: 8, content: {
                if ((hero.name) != nil) {
                    Text("\(hero.name!)")
                        .foregroundColor(Color.black)
                        .font(.caption)
                        .fontWeight(.bold)
                } else {
                    Text("Sin nombre. Error")
                        .foregroundColor(Color.gray)
                        .font(.caption)
                        .fontWeight(.bold)
                }
                if ((hero.description) != nil) {
                    Text("\(hero.description!)")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .lineLimit(4)
                } else {
                    Text("Sin descripcion. Error")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .lineLimit(4)
                }
                
            })
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
           
        } // Fin Vstack
        .onAppear{
            if let _ = viewModel.imagen{} else {
                viewModel.loadImage(with: hero.thumbnail.getUrlThumbnail())
            }
        }
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: Result(id: 1, title: "Nombre Titulo", name: "Nombre nombre", description: "Posible descripcion", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.", thumbnailExtension: Extension.jpg), resourceURI: ""))
    }
}
