//
//  BaseNetwork.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 25/09/2021.
//

import Foundation

//pasamos los parametros
let server  = "http://gateway.marvel.com" // Dirección de marvel
let apikey = "b633d994ddfa0a7d6afaacdebfcf75fe" // Api Key
let ts = "1"
let hash = "8ef7bc7087ff2ba17388e2b557c444db" // hash generado


enum endpoins : String {
    case characters = "/v1/public/characters"
    
    
    struct HTTPMethods{
        static let post = "POST"
        static let get = "GET"
        static let content = "application/json"
    }
    
    
    struct BaseNetwork {
        private func getURL(endpoint:String, subPath:String="") -> String {
            var url = server
            
            url += "\(endpoint)\(subPath)"
            url += "?apikey=\(apikey)"
            url += "&ts=\(ts)"
            url += "&hash=\(String(describing: hash))"
            
            return url
        }
        
        
        // Obtenemos los Personajes
        func getSessionMarvelCharacters() -> URLRequest {
            var urlCad : String = getURL (endpoint: endpoins.characters.rawValue)
            urlCad += "&orderBy=-modified" //para ordenar descendientemente
            
            //Creamos el request para las peticiones
            var request : URLRequest = URLRequest(url: URL(string: urlCad)!) //Esto para ser más eficientes se debería de desempaquetar
            request.httpMethod = HTTPMethods.get
            request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") //Valores a cabecera del Header aplication JSON
            return request
        }
        
        
        // Obtenemos las series
        func getSessionMarvelSeries(idHero:Int) -> URLRequest {
            var urlCad : String = getURL (endpoint: endpoins.characters.rawValue, subPath: "/\(idHero)/series")
            urlCad += "&orderBy=-modified" //para ordenar descendientemente
            
            //Creamos el request para las peticiones
            var request : URLRequest = URLRequest(url: URL(string: urlCad)!) //Esto para ser más eficientes se debería de desempaquetar
            request.httpMethod = HTTPMethods.get
            request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") //Valores a cabecera del Header aplication JSON
            return request
        }
    
    }


}
