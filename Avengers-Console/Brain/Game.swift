//
//  Game.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

class Game {
    private var player1: Player = Player(name: "Team 1")
    private var player2: Player = Player(name: "Team 2")
    private var currentPlayerAttacking: Player
    private var currentPlayerBeeingAttacked: Player
    init() {
        self.currentPlayerAttacking = player1
        self.currentPlayerBeeingAttacked = player2
    }
    
    // MARK: - MainFight
    func mainFight() {
        designatePlayers()
        for _ in 0...2 {
            currentPlayerAttacking.selectCharacterAttacking()
            guard let safeCharacter = currentPlayerAttacking.currentCharacter else { return print("ERROR") }
            switch safeCharacter.id {
                case Characters.doctorStrange.id : // Player choose to heal.
                    currentPlayerAttacking.selectCharacterToHeal()
                default: // Player chose to attack.
                    selectCharacterToBeAttacked(for: currentPlayerBeeingAttacked)
                    currentPlayerAttacking.attack(currentPlayerBeeingAttacked)
                    
            }
            Constant.hitEnterToContinue()
            showAllTeam()
            swapCurrentPlayers()
        }
    }
    
    func designatePlayers(){
        let bool = Bool.random()
        switch bool {
        case true:
            currentPlayerAttacking = player1
            currentPlayerBeeingAttacked = player2
        case false:
            currentPlayerAttacking = player2
            currentPlayerBeeingAttacked = player1
        }
        print("\(currentPlayerAttacking.name) you have been designated to start attacking. ")
    }
    
    func selectCharacterToBeAttacked(for player: Player){
        print(currentPlayerAttacking.name, " Choose a character to attack in other team ?")
        player.showTeam()
        player.selectCharacter()
    }
    

    // MARK: - Initialization
    
    func initializeGame(){
        print(Constant.welcome)
        Characters.displayAllPossibleCharacters()
        Constant.hitEnterToContinue()
        makeAllTeam()
        showAllTeam()
    }
    
    func autoInitialize(){
        print(Constant.welcome)
        Characters.displayAllPossibleCharacters()
        Constant.hitEnterToContinue()
        var counter = 0
        while (counter < 3) {
            let id = Int.random(in: 0...3)
            if !player1.characterAlreadyPresent(character: Characters.allCases[id].character) {
                player1.characters.append(Characters.allCases[id].character)
                counter += 1
            }
        }
        counter = 0
        while (counter < 3) {
            let id = Int.random(in: 0...3)
            if !player2.characterAlreadyPresent(character: Characters.allCases[id].character) {
                player2.characters.append(Characters.allCases[id].character)
                counter += 1
            }
        }
        showAllTeam()
    }
    
    func makeAllTeam(){
        let players = [player1, player2]
        for player in players {
            makeTeam(for: player)
        }
    }
    
    func makeTeam(for player: Player){
        while player.characters.count < 3 {
            var validNumber: Bool = false
            repeat {
                showCurrentSelectionStep(for: player)
                if let selectedCharacter = readLine() {
                    let selectedCharacterId = Int(selectedCharacter)
                    switch selectedCharacterId{
                    case Characters.captain.id:
                        game.add(Characters.captain.character, for: player)
                        validNumber = true
                    case Characters.thor.id:
                        game.add(Characters.thor.character, for: player)
                        validNumber = true
                    case Characters.thanos.id:
                        game.add(Characters.thanos.character, for: player)
                        validNumber = true
                    case Characters.doctorStrange.id :
                        game.add(Characters.doctorStrange.character, for: player)
                        validNumber = true
                    default:
                        print(Constant.youMustSelectValidNumber)
                        validNumber = false
                    }
                }
            } while !validNumber
        }
    }
    
    func add(_ character: Character, for player: Player){
            if player.addCharacter(character) {
                print(Constant.renameThisCharacter, terminator: "")
                if var newName = readLine() {
                    while !canRenameCharacter(with: character.id, newName, for: player) || newName == "" {
                        print(Constant.sorryThisNameIsNonValid, terminator: "")
                        newName = readLine() ?? ""
                    }
                }
                print("\n")
            }
    }
    
    func canRenameCharacter(with id: Int, _ newName: String, for player: Player) -> Bool{
        var output : Bool = false
        if !nameAlreadyExists(name: newName) {
            player.renameCharacter(id: id, name: newName)
            output = true
        }
        return output
    }
    
    func nameAlreadyExists(name: String ) -> Bool { // Returns true if name already exists in Player.characters.
        var output = false
        let characters = player1.characters + player2.characters
        for element in characters {
            let alreadyExist = element.name.localizedStandardContains(name) || element.name.localizedStandardContains(name.uppercased()) || element.name.localizedStandardContains(name.lowercased())
            if alreadyExist {
                output = true
                break
            } else {
                output = false && output
            }
        }
        return output
    }
    
    func swapCurrentPlayers() {
        print(" 🛂 \(currentPlayerBeeingAttacked.name) becomes now atacking team. ", terminator: "")
        if currentPlayerAttacking.id == player1.id {
            currentPlayerAttacking = player2
        } else {
            currentPlayerAttacking = player1
        }
        if currentPlayerBeeingAttacked.id == player1.id {
            currentPlayerBeeingAttacked = player2
        } else {
            currentPlayerBeeingAttacked = player1
        }
    }
    
    func showAllTeam(){
        print("\n")
        print("\n")
        print("\n")
        print("                                                      GAME RECAP ")
        print("\n")
        let players = [player1, player2]
        for player in players {
            player.showTeam()
        }
        Constant.hitEnterToContinue()
        print("\n")
        print("\n")
    }
    
    func showCurrentSelectionStep(for player: Player){
        switch player.characters.count {
        case 0:
            print("\(player.name)", Constant.selectYourFirstCharacter, player.availableCharacters(), terminator: "" )
        case 1: print("\(player.name)", Constant.selectYourSecondCharacter, player.availableCharacters(), terminator: "")
        case 2: print("\(player.name)", Constant.selectYourThirdCharacter, player.availableCharacters(), terminator: "")
        default: Constant.printError()
        }
    }
}
