//
//  Game.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

final class Game { // Joue le rôle de controlleur.
    
    // MARK: - properties
    private var player1: Player
    private var player2: Player
    private var currentAttacker: Player
    private var currentTarget: Player
    private var round : Int = 1
    static var allCharacters : [Character] = []
    
    // MARK: - init()
    
    init() {
        self.player1 = Player(name: Constant.player1Name)
        self.player2 = Player(name: Constant.player2Name)
        self.currentAttacker = player1
        self.currentTarget = player2
    }
    
    // MARK: - Display Results and rounds.

    func displayResults() {
        Constant.displayGameOver()
        if player1.isAlive && !player2.isAlive {
            Game.printWinner(player1, self.round - 1)
        } else if !player1.isAlive && player2.isAlive{
            Game.printWinner(player2, self.round - 1)
        } else {
            Constant.printError()
        }
    }
    
    private func displayRounds(){
        Constant.displayRounds(self.round)
        self.round += 1
    }
    
    private static func printWinner(_ player: Player, _ rounds: Int){
        Constant.playerBecomesTheWinner(player, rounds)
    }
    

    // MARK: - MainFight
    
    func mainFight() {
        displayRounds()
        designatePlayers()
        while player1.isAlive && player2.isAlive  {
            currentAttacker.selectAttackingCharacter()
            guard let safeCharacter = currentAttacker.currentCharacter
            else { return Constant.printError() }
            switch safeCharacter.role {
            case .healer: // Player choose to heal.
                    currentAttacker.selectCharacterToHeal()
                    currentAttacker.heal()
            case .attacker: // Player chose to attack.
                    selectCharacterToBeAttacked()
                    currentAttacker.attack(currentTarget)
            }
            Constant.hitEnterToContinue()
            showAllTeam()
            if player1.isAlive && player2.isAlive {
                displayRounds()
                swapCurrentPlayers()
            }
        }
    }
    
    private func designatePlayers(){
        let bool = Bool.random()
        switch bool {
        case true:
            currentAttacker = player1
            currentTarget = player2
        case false:
            currentAttacker = player2
            currentTarget = player1
        }
        Constant.displayFirstAttacker(currentAttacker)
    }
    
    private func selectCharacterToBeAttacked(){
        Constant.displayChooseCharacterInOtherTeam(currentAttacker)
        currentTarget.showTeam()
        currentTarget.selectCharacterToBeAttacked()
    }
    

    // MARK: - Initialization

    func generalInitialize(_ initialize: Initialize){ // question possible: pq pas de defaut. Différence entre paramètre (signature fonction). et argument (valeur passée).
        switch initialize {
        case .autoInitialize:
            autoInitialize()
        case .initializeForReal:
            initializeGame()
        case .initializeWithAttakersOnly:
            initializeWithAttackersOnly()
        }
    }
    
    private func initializeGame(){
        print(Constant.welcome)
        Characters.displayAllPossibleCharacters()
        Constant.hitEnterToContinue()
        makeAllTeam()
        showAllTeam()
    }
    
    private func makeAllTeam(){
        let players = [player1, player2]
        for player in players {
            player.makeTeam()
        }
    }
    
    private func swapCurrentPlayers() {
        Constant.displaySwapPlayer(currentTarget)
        if currentAttacker.id == player1.id {
            currentAttacker = player2
        } else {
            currentAttacker = player1
        }
        if currentTarget.id == player1.id {
            currentTarget = player2
        } else {
            currentTarget = player1
        }
    }
    
    private func showAllTeam(){
        Constant.displayGameRecap()
        let players = [player1, player2]
        for player in players {
            player.showTeam()
        }
        Constant.hitEnterToContinue()
        Constant.skipLines(1)
    }
}


// MARK: - Initialization extension for Game.

private extension Game {
    
    private static let maxTeams = 2

    private func autoInitialize(){
        print(Constant.welcome)
        Characters.displayAllPossibleCharacters()
        Constant.hitEnterToContinue()
        var counter = 0
        while (counter < Player.maxCharactersPerTeam) {
            let id = Int.random(in: 0...Player.maxCharactersPerTeam)
            if !player1.characterAlreadyPresent(character: Characters.allCases[id].character) {
                player1.characters.append(Characters.allCases[id].character)
                counter += 1
            }
        }
        counter = 0
        while (counter < Player.maxCharactersPerTeam) {
            let id = Int.random(in: 0...Player.maxCharactersPerTeam)
            if !player2.characterAlreadyPresent(character: Characters.allCases[id].character) {
                player2.characters.append(Characters.allCases[id].character)
                counter += 1
            }
        }
        showAllTeam()
    }
    
    private func initializeWithAttackersOnly() {
        print(Constant.welcome)
        Characters.displayAllPossibleCharacters()
        Constant.hitEnterToContinue()
        var counter = 0
        for character in Characters.allCases {
            if counter < Player.maxCharactersPerTeam {
                player1.characters.append(character.character)
                counter += 1
            }
        }
        counter = 0
        for character in Characters.allCases {
            if counter < Player.maxCharactersPerTeam {
                player2.characters.append(character.character)
                counter += 1
            }
        }
        showAllTeam()
    }
}
