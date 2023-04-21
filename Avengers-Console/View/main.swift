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

let game = Game()
game.generalInitialize(.initializeForReal) //  Game is initialized with teams. And returns to main.
game.mainFight()
game.displayResults()

