//
//  MainView.swift
//  MarvelMulti (iOS)
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel : HerosViewModel
    var body: some View {
        
        /* Faltaría implementar la opcion de cargar vista con los cases de Status */
        switch viewModel.status {
            case Status.none:
                Text("Sin cargar vistas!")
            case Status.loading:
                // Pantalla de carga
                LoadingView(texto: "en server")
            case Status.loaded:
                // Se ha cargado
                HerosListView(viewModel: HerosViewModel(comprobar: true))
            case .error(error: let error):
                Text("Error :\(error)")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(HerosViewModel(comprobar: true))
    }
}
