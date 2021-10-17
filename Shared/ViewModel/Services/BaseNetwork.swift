//
//  BaseNetwork.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 25/09/2021.
//

import Foundation

//pasamos los parametros
let server  = "https://gateway.marvel.com" // Dirección de marvel
let apikey = "1a422b3124a35c3fa2178e96f2b76a86c6ec80a4" // Api Key
let ts = "1"
let hash = "0af2bbdef1ada227ab40e0fc709e2a99" // hash generado


enum endpoins : String {
    case characters = "/v1/public/characters"
}
    
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
