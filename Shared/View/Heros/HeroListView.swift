//
//  HeroListView.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import SwiftUI

struct HeroListView: View {
    
    @EnvironmentObject var viewModel: HerosViewModel
    
    var body: some View {
        NavigationView{
            List{
                if let data = viewModel.dataHeros?.data.results{
                    ForEach (data){hero in
                        NavigationLink(destination: SeriesListView(hero: hero), label: {HeroRowView(hero: hero)})
                    }
                }
            }
        }
        .navigationBarTitle("Heroes")
    }
}

struct HeroListView_Previews: PreviewProvider {
    static var previews: some View {
        HeroListView()
    }
}
