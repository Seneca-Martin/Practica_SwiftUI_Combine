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
    @Published var dataSeries: StatusModel?
    var suscriptor = Set<AnyCancellable>()
    
    func loadMarvelSeries(hero:Int){
        
        self.status = Status.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionMarvelSeries())
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                       response.statusCode == 200 else {

                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: dataSeries.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = Status.error(error: "Se ha producido un Error")
                case .finished:
                    self.status = Status.loaded
                }
               
            } receiveValue: { data in
                self.heros = data
            }
            .store(in: &suscriptors)
        
    }
    
}
