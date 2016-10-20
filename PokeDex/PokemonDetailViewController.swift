//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Jason Wang on 10/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonDetailViewController: UIViewController, AVSpeechSynthesizerDelegate {

    var pokemon: Pokemon?
    let synthesizer = AVSpeechSynthesizer()
    var isPaused = true

    @IBOutlet weak var pkimageView: UIImageView!
    @IBOutlet weak var pkIDLabel: UILabel!
    @IBOutlet weak var pkType1ImageView: UIImageView!
    @IBOutlet weak var pkType2ImageView: UIImageView!
    @IBOutlet weak var pkDescriptionTextView: UITextView!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var pkType1ImageViewCenterXConstrain: NSLayoutConstraint!

    @IBOutlet weak var pkNameLabel: UILabel!
    @IBOutlet weak var pokeballImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pokémon Detail"
        voiceButton.layer.cornerRadius = 37.5
        synthesizer.delegate = self
        setupPokemonData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        roatePokeBall()
    }

    func roatePokeBall() {
        UIView.animate(withDuration: 2.0, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            for _ in 0..<4 {
                self.setPokeballTransformRotate180()
            }
            }, completion: { (didFinish) in
                if didFinish {
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                        self.pkimageView.transform = self.pkimageView.transform.scaledBy(x: 1.5, y: 1.5)
                        }, completion: { (didFinishScale) in
                            if didFinishScale {
                                self.pkimageView.transform = .identity
                            }
                    })
                }
        })
    }

    fileprivate func setPokeballTransformRotate180 () {
        pokeballImageView.transform = pokeballImageView.transform.rotated(by: CGFloat(M_PI))
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        synthesizer.stopSpeaking(at: .immediate)
    }

    func setupPokemonData() {
        guard let pk = pokemon else { return }
        pkimageView.downloadImage(urlString: pk.imageUrlString)
        pkIDLabel.text = String(pk.pkDexID)
        pkNameLabel.text = pk.name.uppercased()
        pkDescriptionTextView.text = pk.description
        for (index, type) in pk.types.enumerated() {
            if index == 0 {
                pkType1ImageView.image = UIImage(named: type)
                pkType1ImageViewCenterXConstrain.constant = 0
            } else {
                pkType2ImageView.image = UIImage(named: type)
                pkType1ImageViewCenterXConstrain.constant = -20
            }
        }
    }


    @IBAction func pkVoiceButtonTapped(_ sender: UIButton) {
        guard let pk = pokemon else { return }
        let myUtterance = AVSpeechUtterance(string: speechStringFor(pokemon: pk))
        myUtterance.rate = 0.48
        myUtterance.pitchMultiplier = 1.3
        if isPaused {
            synthesizer.speak(myUtterance)
            isPaused = false
        } else {
            synthesizer.stopSpeaking(at: .immediate)
            isPaused = true
        }
        setState(button: voiceButton, forPause: isPaused)
    }

    func setState(button: UIButton, forPause pausedState: Bool) {
        var imageName = "MicGray"
        if pausedState {
            imageName = "MicColor"
        }
        button.setImage(UIImage(named: imageName), for: .normal)
    }

    func speechStringFor(pokemon: Pokemon) -> String {
        let name = pokemon.name
        var types = pokemon.types[0]
        if pokemon.types.count > 1 {
            types += ", and \(pokemon.types[1])"
        }
        guard let descriptionTxt = pkDescriptionTextView.text else { return "\(name). is \(types) type Pokeymaun." }
        let replacedText = descriptionTxt.replacingOccurrences(of: "Pokémon", with: "Pokeymaun").replacingOccurrences(of: "Pokémon's", with: "Pokeymaun's")
        let textToSpeak = "\(name). is, \(types) type Pokeymaun. \(replacedText)"
        return textToSpeak
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        setState(button: voiceButton, forPause: true)
        isPaused = true
    }

}
