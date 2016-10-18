//
//  PokemonTableViewCell.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pkImageView: UIImageView!
    @IBOutlet weak var pkNameLabel: UILabel!
    @IBOutlet weak var pkIDLabel: UILabel!
    @IBOutlet weak var pkType1ImageView: UIImageView!
    @IBOutlet weak var pkType2ImageView: UIImageView!

    var pokemon: Pokemon? {
        didSet {
            guard let pk = pokemon else { return }
            setData(pokemon: pk)
        }
    }

    override func prepareForReuse() {
        pkType1ImageView.image = nil
        pkType2ImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        pkImageView.layer.cornerRadius = 20
    }

    fileprivate func setData(pokemon: Pokemon) {
        let pkDexIDString = String(pokemon.pkDexID)
        pkImageView.image = UIImage(named: pkDexIDString)
        pkIDLabel.text = pkDexIDString
        pkNameLabel.text = pokemon.name
        for (index, stringType) in pokemon.types.enumerated() {
            if index == 0 {
                pkType1ImageView.image = UIImage(named: stringType)
            } else {
                pkType2ImageView.image = UIImage(named: stringType)
            }
        }
    }

}
