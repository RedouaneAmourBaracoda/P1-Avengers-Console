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
    private var allCharacters: [Character] {
        var output : [Character] = []
        let allPlayers : [Player] = [player1, player2]
        for player in allPlayers {
            for character in player.characters {
                output.append(character)
            }
        }
        return output
    }
    private var currentPlayer: Player
    
    init() {
        currentPlayer = player1
        
    }
    
    func initializeGame(){
        print(Constant.welcome)
        Characters.displayAllPossibleCharacters()
        print("Hit enter to continue")
        let _ = readLine()
        let players = [player1, player2]
        for player in players {
            currentPlayer = player
            makeTeam(for: player)
        }
        let _ = readLine()
        for element in allCharacters {
            print(element.name)
        }
    }
    
    func makeTeam(for player: Player){
        while player.characters.count < 3 {
            var validNumber: Bool = false
            repeat {
                print("\(player.name), please select character with valid number (1, 2, 3 or 4): ")
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
                        print("You must enter a whole number between 1 and 4 ")
                        validNumber = false
                    }
                }
            } while !validNumber
        }
        showTeam(for: player)
    }
    
    func add(_ character: Character, for player: Player){
            if player.addCharacter(character) {
                print("Rename this character : ")
                if var newName = readLine() {
                    while !canRenameCharacter(with: character.id, newName, for: player) || newName == ""{
                        print("sorry this name is either non-valid or already taken, pick something else: ")
                        newName = readLine() ?? ""
                    }
                }
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
    
    func showTeam(for player: Player) {
            print("\(currentPlayer.name), This your team : \n")
            for character in player.characters {
                Characters.showCharacter(character)
            }
    }
    
    func changeCurrentPlayer() {
        if currentPlayer.id == player1.id {
            currentPlayer = player2
        } else {
            currentPlayer = player1
        }
    }
}
