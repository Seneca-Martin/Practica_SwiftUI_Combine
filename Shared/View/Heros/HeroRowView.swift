//
//  HeroRowView.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import SwiftUI

struct HeroRowView: View {
    @StateObject private var photoViewModel = PhotoViewModel()
    
    var hero: Result
    
    init(hero:Result){
        self.hero = hero
    }
    
    var body: some View {
        VStack{
            if let photo = photoViewModel.photo{
                photo
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
            } else {
                
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    .opacity(0.6)
            }
            
            Text("\(hero.name)")
                .font(.title)
                .foregroundColor(.gray)
                .bold()
        }
        .onAppear{
            photoViewModel.loadImage(url: hero.getUrlImage(type: .portrait))
        }
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: HerosViewModel().getTestHero)
    }
}
