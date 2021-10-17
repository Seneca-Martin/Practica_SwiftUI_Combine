//
//  SeriesRowView.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import SwiftUI

struct SeriesRowView: View {
    var serie:Result
    @StateObject private var photoViewModel = PhotoViewModel()

    var body: some View {
        VStack{
            ZStack{
                if let photo = photoViewModel.photo {
                    photo
                        .resizable()
                        .opacity(0.3)
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .opacity(0.3)
                        .aspectRatio(contentMode: .fit)
                }
                
                if let titulo = serie.title{
                    Text("\(titulo)")
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                }
            }
                if let descrip = serie.description{
                    Text("\(descrip)")
                        .foregroundColor(.gray)
                        .font(.body)
                }else {
                    Text("Sin descripcion")
                        .foregroundColor(.gray)
                        .font(.body)
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray.opacity(0.4))
        )
        .onAppear{
            if let _ = photoViewModel.photo{
                return
            }else {
                photoViewModel.loadImage(url: serie.thumbnail.getUrlImage(type: .portrait))
            }
        }
    }
}
    

struct SeriesRowView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRowView(serie: SeriesViewModel().getTestSerie())
        }
    }
