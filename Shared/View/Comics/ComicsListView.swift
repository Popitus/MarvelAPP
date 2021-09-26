//
//  ComicsListView.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import SwiftUI

struct ComicsListView: View {
        
    var comic: Result
    @ObservedObject var viewComicHeros: ComicsViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            if let data = viewComicHeros.dataHeros?.data.results {
                ForEach(data) { comic in
                    ComicsRowView(comic: comic, comicViewModel: viewComicHeros)
                }
            }
        })
        .navigationBarTitle("Comics de: \(comic.name!)", displayMode: .inline)
    }
}


struct ComicsListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsListView(comic: Result(id: 1, title: "Nombre Titulo", name: "Nombre Nombre", description: "Descripcion", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.", thumbnailExtension: Extension.jpg), resourceURI: ""), viewComicHeros: ComicsViewModel(with: 1))
    }
}
