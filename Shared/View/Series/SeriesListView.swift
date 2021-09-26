//
//  SeriesListView.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import SwiftUI

struct SeriesListView: View {
    var hero:Result
    @StateObject private var viewModel = SeriesViewModel()
    
    init (hero:Result){
        self.hero = hero
    }
    
    var body: some View {
        switch viewModel.status {
        case Status.none:
            Group {
                Text("")
                let _ = viewModel.loadMarvelSeries(hero: hero.id)
            }
        }
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(hero: <#Result#>)
    }
}
