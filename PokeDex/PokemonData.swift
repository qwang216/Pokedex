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
    
    var pokemons: [Pokemon]?

    init() {

    }
    func loadAllPokemonsOn(tableView: UITableView) {
        PKAPIHelper.pokedexManager.fetchAllPokemons { (jsonDict, response, errorMessage) in
            guard let pkDicts = jsonDict else { return }
            self.pokemons = [Pokemon]()
            for pkDict in pkDicts {
                guard let pokemon = Pokemon(withDict: pkDict) else { continue }
                self.pokemons?.append(pokemon)
            }
            tableView.reloadData()
        }
    }
}
