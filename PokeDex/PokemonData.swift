//
//  PokemonData.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import Foundation

class PokemonData {
    
    var pokemons: [Pokemon]?

    init() {
        PKAPIHelper.pokedexManager.fetchAllPokemons { (jsonDict, response, errorMessage) in
            guard let pkDicts = jsonDict else { return }
            for pkDict in pkDicts {
                guard let pokemon = Pokemon(withDict: pkDict) else { continue }
                self.pokemons?.append(pokemon)
            }
        }
    }
}
