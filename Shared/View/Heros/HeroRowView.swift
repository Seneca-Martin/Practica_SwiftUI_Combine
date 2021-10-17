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
            //foto
            if let photo = photoViewModel.photo{
                // foto descargada
                photo
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
            } else {
                // no tiene foto
                Image(systemName: "photo")
                    .resizable()
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.6)
            }
            //titulo
            if let name = hero.name{
                Text("\(name)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)
                    .bold()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.4))
        )
        .onAppear{
            if let _ = photoViewModel.photo{
                //si esta la foto. no hafo na de na
                return
            }
            else{
                self.photoViewModel.loadImage(url: self.hero.thumbnail.getUrlImage(type: .landscape))
            }
        }
        
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: HerosViewModel().getHero())
        .previewLayout(.fixed(width: 350, height: 350))
    }
}
