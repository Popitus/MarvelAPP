//
//  ComicsRowView.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import SwiftUI

struct ComicsRowView: View {
    var comic:Result
    @StateObject private var viewModel: PhotoViewModel = PhotoViewModel()
    @StateObject var comicViewModel: ComicsViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 15, content: {
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
            VStack(alignment: .leading, spacing: 8, content: {
                // se podria hacer con un if let
                if ((comic.title) != nil) {
                    Text("\(comic.title!)")
                        .font(.title3)
                        .fontWeight(.bold)
                } else {
                    Text("Sin nombre. Error")
                }
                // Se podria hacer con un if let
                if ((comic.description) != nil) {
                    Text("\(comic.description!)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
            })
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }) // Fin Vstack
        .onAppear{
            if let _ = viewModel.imagen{} else {
                viewModel.loadImage(with: comic.thumbnail.getUrlThumbnail())
            }
        }
    }
}

struct ComicsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsRowView(comic: Result(id: 1, title: "Nombre Titulo", name: "Nombre nombre", description: "Es una descripcion", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.", thumbnailExtension: Extension.jpg), resourceURI: ""), comicViewModel: ComicsViewModel(with: 1))
    }
}
