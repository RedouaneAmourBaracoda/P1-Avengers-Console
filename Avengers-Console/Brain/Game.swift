//
//  Game.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

class Game {
    static var allCharacters: [Character] = []
    var player1: Player = Player(name: "Team 1")
    var player2: Player = Player(name: "Team 2")

    private var currentPlayer: Player
    
    init() {
        currentPlayer = player1
    }
    
    func initializeGame(){
        print(Constant.welcome)
        Characters.displayAllPossibleCharacters()
        print("Hit enter to continue")
        let _ = readLine()
        while player1.characters.count < 3 {
            var validNumber: Bool = false
            repeat {
                print("\(player1.name), please select character with valid number (1, 2, 3 or 4): ")
                if let selectedCharacter = readLine() {
                    let selectedCharacterId = Int(selectedCharacter)
                    switch selectedCharacterId{
                    case Characters.captain.id:
                        game.add(Characters.captain.character)
                        validNumber = true
                    case Characters.thor.id:
                        game.add(Characters.thor.character)
                        validNumber = true
                    case Characters.thanos.id:
                        game.add(Characters.thanos.character)
                        validNumber = true
                    case Characters.doctorStrange.id :
                        game.add(Characters.doctorStrange.character)
                        validNumber = true
                    default:
                        print("You must enter a whole number between 1 and 4 ")
                        validNumber = false
                    }
                }
            } while !validNumber
        }
        showTeam()
    }
    
    func add(_ character: Character){
        switch currentPlayer.id {
        case self.player1.id :
            if self.player1.addCharacter(character) {
                print("Rename this character : ")
                if var newName = readLine() {
                    while !canRenameCharacter(with: character.id, newName) || newName == ""{
                        print("sorry this name is either non-valid or already taken, pick something else: ")
                        newName = readLine() ?? ""
                    }
                }
            }
        //case self.player2.id: self.player2.addCharacter(character)
        default: print("error")
        }
    }
    
    func canRenameCharacter(with id: Int, _ newName: String) -> Bool{
        var output : Bool = false
        if !nameAlreadyExists(name: newName) {
            switch currentPlayer.id {
            case self.player1.id :
                player1.renameCharacter(id: id, name: newName)
            default :
                player2.renameCharacter(id: id, name: newName)
            }
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
    
    func showTeam() {
        switch currentPlayer.id {
        case player1.id:
            print("\(currentPlayer.name), This your team : \n")
            for character in player1.characters {
                Characters.showCharacter(character)
            }
        case player2.id:
            print("\(currentPlayer.name), This your team : \n")
            for character in player2.characters {
                Characters.showCharacter(character)
            }
        default:
            print("error")
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var player1 : Player
//    var player2 : Player
//
//    var numberOfCharactersForPlayer1: Int {
//        return player1.characters.count
//    }
//
//    var numberOfCharactersForPlayer2: Int {
//        return player2.characters.count
//    }
//
//    var allCharacters: [Character] {
//        return player1.characters + player2.characters
//    }
//
//    init() {
//        self.player1 = Player()
//        self.player2 = Player()
//    }
//
//    func add(_ character: Character, to player : Player){
//        switch player.id {
//        case self.player1.id : self.player1.addCharacter(character)
//        default: self.player2.addCharacter(character)
//        }
//    }
//
//    func renameCharacter(for player: Player, with id: Int, _ newName: String) -> Bool{
//        var output : Bool = false
//        if !nameAlreadyExists(name: newName) {
//            switch player.id {
//            case self.player1.id :
//                player1.renameCharacter(id: id, name: newName)
//            default :
//                player2.renameCharacter(id: id, name: newName)
//            }
//            output = true
//        }
//        return output
//    }
//
//    func nameAlreadyExists(name: String ) -> Bool { // Returns true if name already exists in Player.characters.
//        var output = false
//        let characters = self.player1.characters + self.player2.characters
//        for element in characters {
//            let alreadyExist = element.name.localizedStandardContains(name) || element.name.localizedStandardContains(name.uppercased()) || element.name.localizedStandardContains(name.lowercased())
//            if alreadyExist {
//                output = true
//                break
//            } else {
//                output = false && output
//            }
//        }
//        print("output: \(output)")
//        return output
//    }
//
//    func allNamesAreUnique() -> Bool {
//        var output: Bool = false
//        var names: [String] = []
//        for element in allCharacters {
//            names.append(element.name)
//        }
//        let set: Set<String> = Set(names)
//        if set.count  == 6 {
//            output = true
//        }
//        return output
//    }
//
//    static var allCharacters: [Character] = Game.startGame()
//
//    static let initialCharacters : [Character] = Game.startGame()
//

