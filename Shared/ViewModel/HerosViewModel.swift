//
//  HerosViewModel.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import Combine
import SwiftUI

final class HerosViewModel: ObservableObject {
    
    @Published var status: Status = .none  //Estado
    @Published var dataHeros: MarvelModel? //datos de los heroes
    
    var suscriptor = Set<AnyCancellable>()
    
    init(testing:Bool=false){
        if !testing {
            loadMvHeros()
        }
        else{
            getHerosTesting()
        }
    }
    
    
    func loadMvHeros(){
        self.status = .loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionMarvelCharacters())
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                       response.statusCode == 200 else {
                    self.status = Status.error(error: "Error de llamada a la API")
                    throw URLError(.badServerResponse)
                }
                
                // Si todo Ok
                return $0.data
            }
            .decode(type: MarvelModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    self.status = Status.error(error: error.localizedDescription)
                case .finished:
                    self.status = Status.loaded
                }
               
            } receiveValue: { MarvelModel in
                self.dataHeros = MarvelModel
            }
            .store(in: &suscriptor)
    }
    


    
    
    // Para Testing
    func getHerosTesting(){
        let hero1 = Result(id: 1009351, title: "", name: "Hulk Testing", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", thumbnailExtension: Extension.jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009351")
        
        let hero2 = Result(id: 1009165, title: "", name: "Avengers", description: "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/20/5102c774ebae7", thumbnailExtension: Extension.jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009165")
        
        
        let data = DataMarvel(offset: 0, limit: 0, total: 2, count: 2, results: [hero1, hero2])
        self.dataHeros = MarvelModel(code: 200, stratus: "Success", copyright: "2021", attibutioText: "", attributionHTML: "", etag: "", data:data )
        self.status = Status.loaded
    }
    
    func getHero() -> Result {
        return  Result(id: 1009351, title: "", name: "Hulk Testing", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", thumbnailExtension: Extension.jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009351")
    }
}
