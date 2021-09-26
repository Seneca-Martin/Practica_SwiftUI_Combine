//
//  MainView.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: HerosViewModel
    
    var body: some View {
        switch viewModel.status {
        case Status.none:
            Text("Estado NONE")
        case Status.loading:
            LoadingView()
        case Status.loaded:
            HeroListView()
        case Status.error(error: let errorString):
            Text("Error: \(errorStrin)")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
