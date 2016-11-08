//
//  PokemonData.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import Foundation
import UIKit

class PokemonData {
    
    var pokemons = [Pokemon]()

    func loadAllPokemonsOn(completion: @escaping (_ didFinishLoading: Bool) -> Void) {
            PKAPIHelper.instance.fetchAllPokemons { (jsonDict, response, errorMessage) in
                guard let pkDicts = jsonDict else { return }
                self.pokemons.removeAll()
                for pkDict in pkDicts {
                    guard let pokemon = Pokemon(withDict: pkDict) else { continue }
                    self.pokemons.append(pokemon)
                }
                completion(true)
            }
    }
}
