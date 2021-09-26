//
//  RootViewModel.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 25/09/2021.
//

import Foundation
import Combine

class RootViewModel: ObservableObject {
    @Published var status = Status.none // para el estado de las llamada a red
    @Published var isLogged :Bool = false // nos indica si estamos logados o no
    @Published var tokenJWT :String = "" //token del servidor
    
    
    var suscriptors = Set<AnyCancellable>()
    
    // Pedir login al servidor
    func login(user:String, password:String){
        
    }
    
}
