//
//  HerosListView.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import SwiftUI

struct HerosListView: View {
    @StateObject var viewModel: HerosViewModel
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .center, spacing: 15, content: {
                    // HStack de la lupa con texto de busqueda
                    HStack(alignment: .center, spacing: 10, content: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.gray)
                        TextField("Search Hero", text: $viewModel.cajaBusqueda)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    })
                    // Maquetación de la barra
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0.0, y: 5)
                })
                .navigationBarTitle("Heroes")
                .padding()
                if let data = viewModel.dataHeros {
                    if data.isEmpty {
                        // Sin resultado
                        Text("Sin resultado")
                            .padding(.top, 20)
                    } else {
                        ForEach(data) { hero in
                            NavigationLink(
                                destination:
                                    // Siguiente vista con los comics segun el superheroe elegido
                                    ComicsListView(comic: hero, viewComicHeros: ComicsViewModel(with: hero.id)),
                                label: {
                                    // Listado de superHeroes
                                    HeroRowView(hero: hero)
                                })
                        }
                    }
                } else {
                    // Cargamos loading
                    if viewModel.cajaBusqueda != "" {
                        LoadingView(texto: "superhéroe")
                            .padding(.top, 20)
                    }
                }
            })
        }
    }
}


struct HerosListView_Previews: PreviewProvider {
    static var previews: some View {
        HerosListView(viewModel: HerosViewModel(comprobar: true))
    }
}
