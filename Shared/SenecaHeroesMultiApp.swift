//
//  SenecaHeroesMultiApp.swift
//  Shared
//
//  Created by seneca on 24/09/2021.
//

import SwiftUI

@main
struct SenecaHeroesMultiApp: App {
    @StateObject var viewModelHeros = HerosViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModelHeros)
        }
    }
}
