//
//  MarvelMultiApp.swift
//  Shared
//
//  Created by Oliver Ramírez Cáceres on 24/9/21.
//

import SwiftUI

@main
struct MarvelMultiApp: App {
    @StateObject var homeViewModel: HerosViewModel = HerosViewModel(comprobar: false)
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(homeViewModel)
        }
    }
}
