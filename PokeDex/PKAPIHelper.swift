//
//  PKAPIHelper.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import Foundation

class PKAPIHelper {
    static let instance = PKAPIHelper()
    private init() {}

//    func fetchAllPokemons(completion: @escaping (_ jsonObject: [[String: Any]]?, _ response: URLResponse?, _ errMsg: String?) -> ()) {
//        let pkAPIString = "http://okaymon.mybluemix.net/api/pokemon"
//        guard let pkAPIURL = URL(string: pkAPIString) else { return }
//        var request = URLRequest(url: pkAPIURL)
//        request.httpMethod = "GET"
//        let session = URLSession.shared
//            session.dataTask(with: request) { (data, response, error) in
//                guard let jsonData = data else { return }
//                var json: [[String: Any]]?
//                do {
//                    json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
//                } catch let err {
//                    print("Pokedex API error ==> \n\(err)")
//                }
//                let errorString = error?.localizedDescription
//                DispatchQueue.main.async {
//                    completion(json, response, errorString)
//                }
//                }.resume()
//    }

    func fetchAllPokemons(completion: @escaping (_ jsonObject: [[String: Any]]?, _ response: URLResponse?, _ errMsg: String?) -> ()) {
        guard let path = Bundle.main.path(forResource: "PokemonData", ofType: "json"), let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
        let dict = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? [[String: Any]] else {
                return
        }
        completion(dict, nil, nil)
    }


}
