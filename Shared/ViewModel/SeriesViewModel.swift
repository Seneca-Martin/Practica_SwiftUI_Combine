//
//  SeriesViewModel.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import Foundation
import Combine

final class SeriesViewModel: ObservableObject{
    
    @Published var status = Status.none
    @Published var dataSeries: MarvelModel?
    var suscriptor = Set<AnyCancellable>()
    
    func loadMarvelSeries(hero:Int){
        
        self.status = Status.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionMarvelSeries(idHero: hero))
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else{
                    self.status = Status.error(error: "Error al acceder a las series en la API de Marvel")
                    throw URLError(.badServerResponse)
                }
                //TOdo OK
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
                self.dataSeries = MarvelModel
            }
            .store(in: &suscriptor)

    }
    
    // Testing Data -----
    
    func getHeroTest() -> Result {
        return  Result(id: 1009351, title: "", name: "Hulk Testing", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", thumbnailExtension: Extension.jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009351")
    }
    
    
    func getTestSerie() -> Result{
        return  Result(id: 1009146, title: "Moon Girl and Devil Dinosaur (2015 - 2019)", name: "", description: "The flagship X-Men comic for over 40 years, Uncanny X-Men delivers action, suspense, and a hint of science fiction month in and month out. Follow the adventures of Professor Charles Xavier's team of mutants as they attempt to protect a world that hates and fears them.", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/e0/56d0caf175be0", thumbnailExtension: Extension.jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009146")
    }
    
}
