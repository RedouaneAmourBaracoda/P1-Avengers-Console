//
//  main.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation


enum Initialize {
    case autoInitialize
    case initializeForReal
    case initializeWithAttakersOnly
}

// Modele MVC adapé à la console. Evoquer GitHub pour le versionning du projet.

// Insérer dans la présentation les aspects pris en compte pour ce projet : GitHub, Single responsability principle, MVC Architecture, Swiftlint, protocole, extension.

let game = Game()
game.generalInitialize(.autoInitialize)
game.mainFight()
game.displayResults()
