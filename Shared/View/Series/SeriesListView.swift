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
        case Status.loading:
            LoadingView()
        case Status.error(error: let errorString):
            Text("Error: \(errorString)")
                .foregroundColor(Color.red)
        case Status.loaded:
            
            #if os(macOS)
            List {
                if let data = viewModel.dataSeries?.data.results{
                    ForEach(data){ serieModel in
                        SeriesRowView(serie: serieModel)
                    }
                }
            }
            #else
            List {
                if let data = viewModel.dataSeries?.data.results{
                    ForEach(data){ serieModel in
                        SeriesRowView(serie: serieModel)
                    }
                }
            }
            .navigationBarTitle("Series \(hero.name!)")
            #endif
        }
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(hero: SeriesViewModel().getTestSerie())
    }
}
