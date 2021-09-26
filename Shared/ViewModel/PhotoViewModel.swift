//
//  PhotoViewModel.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import Combine
import SwiftUI

class PhotoViewModel: ObservableObject{
    @Published var photo:Image?
    
    var suscriptor = Set<AnyCancellable>()
    
    func loadImage(url:String){
        let urlDownload = URL(string: url)!
        
        URLSession.shared
            .dataTaskPublisher(for: urlDownload)
            .map{reponse -> UIImage in
                UIImage(data: response.data)
            }
            .replaceError(with: Image(systemName: "person.fill"))
            .replaceNil(with: Image(systemName: "person.fill"))
            .recive(on: DispatchQueue.main)
            .sink { image in
                self.photo = image
                }
            .store(in: &suscriptor)
    }
}
