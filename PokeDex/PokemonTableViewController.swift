//
//  PokemonTableViewController.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController, UISearchBarDelegate {

    let pokemonData = PokemonData()
    var displayPokemons = [Pokemon]() {
        didSet {
            tableView.reloadData()
        }
    }
    var isSearching = false

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Enter Pokemon Name or Type"
        return sb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonData.loadAllPokemonsOn { (didFinishLoad) in
            if didFinishLoad {
                self.displayPokemons = self.pokemonData.pokemons
                self.animateTableView()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animateTableView()
        setupSearchBar()
    }

    func setupSearchBar() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        let searchbarView = UIView(frame: frame)
        searchbarView.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: searchbarView.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: searchbarView.rightAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: searchbarView.frame.height).isActive = true
        tableView.tableHeaderView = searchbarView
    }

    func animateTableView() {
        let cells = tableView.visibleCells
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableView.bounds.height + 100)
            let delay = Double(index) * 0.1
            UIView.animate(withDuration: 0.5, delay: delay , usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                cell.transform = .identity
                }, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayPokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pkCellID", for: indexPath) as! PokemonTableViewCell
        cell.pokemon = displayPokemons[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedPokemon = displayPokemons[indexPath.row]
        performSegue(withIdentifier: "detailPKVCSegueID", sender: selectedPokemon)
    }

    // MARK: - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let pokemons = pokemonData.pokemons
        if searchText.count > 0 {
            let predicate = NSPredicate(format: "name contains[c] %@ or any types contains[c] %@", searchText, searchText)
            displayPokemons = pokemons.filter { predicate.evaluate(with: $0) }
//            displayPokemons = pokemons.filter({ (pokemon) -> Bool in
//                let lowercasedText = searchText.lowercased()
//                return pokemon.name.lowercased().contains(lowercasedText) || pokemon.types.contains(where: { $0.lowercased().contains(lowercasedText) })
//            })
        } else {
            displayPokemons = pokemons
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPKVCSegueID" {
            let pokemonDetailVC = segue.destination as? PokemonDetailViewController
            pokemonDetailVC?.pokemon = sender as? Pokemon
        }
    }

}
