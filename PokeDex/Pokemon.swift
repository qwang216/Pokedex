//
//  Pokemon.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import Foundation
class Pokemon: NSObject {
    @objc let name: String
    let pkDexID: Int
    let imageUrlString: String
    let descriptionString: String
    @objc let types: [String]

    init(name: String, pkDexID: Int, imageUrl: String, description: String, types: [String]) {
        self.name = name
        self.pkDexID = pkDexID
        self.imageUrlString = imageUrl
        self.descriptionString = description
        self.types = types
    }

    convenience init?(withDict pkDict: [String: Any]) {
        if let name = pkDict["name"] as? String,
            let id = pkDict["pkdx_id"] as? Int,
            let urlString = pkDict["art_url"] as? String,
            let pkDescription = pkDict["description"] as? String,
            let pkTypes = pkDict["types"] as? [String] {
            self.init(name: name, pkDexID: id, imageUrl: urlString, description: pkDescription, types: pkTypes)
        } else {
            return nil
        }
    }

}
