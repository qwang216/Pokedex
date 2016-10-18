//
//  PokemonTableViewController.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    let pokemonData = PokemonData()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonData.loadAllPokemonsOn(tableView: tableView)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = pokemonData.pokemons?.count else { return 0 }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pkCellID", for: indexPath) as! PokemonTableViewCell
        cell.pokemon = pokemonData.pokemons?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonData.pokemons?[indexPath.row]
        performSegue(withIdentifier: "detailPKVCSegueID", sender: selectedPokemon)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPKVCSegueID" {
            let pokemonDetailVC = segue.destination as? PokemonDetailViewController
            pokemonDetailVC?.pokemon = sender as? Pokemon
        }
    }

}
