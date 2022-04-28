//
//  PokeViewModel.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 22/04/22.
//

import Foundation

class PokeViewModel {
    
    var pokemones = [Result]()
    
    let URL_API = "https://pokeapi.co/api/v2/pokemon"
    
    func getDataFromAPI() async {
        
        guard let url = URL(string: URL_API) else { return }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decoder = try? JSONDecoder().decode(Pokemon.self, from: data){
                
                DispatchQueue.main.async(execute: {
                    decoder.results.forEach{ pokemon in
                        self.pokemones.append(pokemon)
                                             
                    }
                })
                
            }
            
            
        } catch {
            
            print("error found")
            
        }
        
    }
    
    //func getDataFromAPI() {
    //
    //    guard let url = URL(string: URL_API) else {return}
    //
    //    let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //
    //        if let data = data {
    //
    //           let decode = String(data: data, encoding: .utf8)
    //            print(decode!)
    //
    //        }
    //
    //    }
    //
    //    task.resume()
    //
    //}
    
    
}
