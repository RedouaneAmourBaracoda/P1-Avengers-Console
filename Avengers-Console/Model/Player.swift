//
//  Player.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

class Player {
    let id = UUID()
    var characters : [Character] = []
    var currentCharacter: Character?
    let name : String
    var isAlive : Bool {
        var output = true
        if characters.count == 3 {
            var aliveCharacters : [Character] = []
            for character in characters {
                if !character.isDead {
                    aliveCharacters.append(character)
                }
            }
            if aliveCharacters.count == 0 || (aliveCharacters.count == 1 && aliveCharacters.contains(where: { character in
                character.id == Characters.doctorStrange.id
            })) {
                output = false
            }
        }
        return output
    }
    
    
    init(name: String) {
        self.name = name
    }
    
    // MARK: - Player MainFight
    
    
    func selectCharacterAttacking(){
        print("\(self.name) select a character for attacking: ", terminator: "")
        self.selectCharacter()
    }
    
    func selectCharacterToHeal(){
        print("\(self.name) select a character to heal: ", terminator: "")
        self.selectCharacter()
        self.heal()
        self.updateCharacter()
    }
    
    func attack(_ player: Player){
        guard let _ = player.currentCharacter, let _ = self.currentCharacter else { return
            print("there was an error while attacking: one of the players has his current character not initialized.")
        }
        player.currentCharacter?.life -= (self.currentCharacter?.weapon.strengh)!
        print(self.currentCharacter!.name, " used his ", self.currentCharacter!.weapon.name, self.currentCharacter!.weapon.emoji, "to attack ", player.currentCharacter!.name, " who has lost ", self.currentCharacter!.weapon.strengh, " life points ")
        player.updateCharacter()
    }
    
    func heal() {
        guard let _ = self.currentCharacter else { return
            print("there was an error while attacking: one of the players has his current character not initialized.")
        }
        self.currentCharacter?.life += Characters.doctorStrange.weapon.strengh
        print(self.currentCharacter!.name, " was healed and now has a life of ", self.currentCharacter!.life, " life points ")
    }
    
    enum InvalidNumber {
        case outOfBound
        case characterIsDead
    }
    enum SelectedNumber: Equatable {
        case valid
        case invalid(InvalidNumber)
    }

    func selectCharacter(){
        var validNumber: SelectedNumber = .invalid(.outOfBound)
            repeat {
                    if let selectedCharacter = readLine() {
                        let selectedCharacterId = Int(selectedCharacter)
                        for character in characters {
                            if character.id == selectedCharacterId {
                                if !character.isDead {
                                    self.currentCharacter = character
                                    validNumber = .valid
                                    break
                                } else {
                                    validNumber = .invalid(.characterIsDead)
                                    break
                                }
                            }
                            validNumber = .invalid(.outOfBound)
                        }
                        switch validNumber {
                        case .valid:
                            break
                        case .invalid(let invalidNumber):
                            youMustSelectValidCharacter(invalidNumber)
                        }
                    }
            } while validNumber == .invalid(.outOfBound) || validNumber == .invalid(.characterIsDead)
    }
    
    func updateCharacter(){
        guard let safeCharacter = currentCharacter, characters.count > 0 else { return print("ERROR")}
        for index in 0...characters.count - 1 {
            if safeCharacter.id == characters[index].id {
                characters[index] = safeCharacter
                characters[index].die() // Only if no more life.
            }
        }
    }
    
    func youMustSelectValidCharacter(_ invalidNumber: InvalidNumber ){
        let characters = self.characters
        var string = "("
        for character in characters {
            if !character.isDead {
                if character.id == characters.last?.id {
                    string.append(String(character.id) + ")")
                } else {
                    string.append(String(character.id) + ", ")
                }
            }
        }
        switch invalidNumber {
        case .characterIsDead :
            print("🪦 Sorry this character is not alive anymore 🪦. May he rest in peace 👼🏻.", terminator: "")
            print(" You can only select alive character -> ", string)
        case .outOfBound:
            print("Sorry this number is out of bounds.", terminator: "")
            print(" You can only select valid character -> ", string)
        }
        
    }
    

    // MARK: - Player initialization

    func addCharacter(_ character: Character) -> Bool{
        var output = false
        if  self.characters.count < 3 && !characterAlreadyPresent(character: character){
            characters.append(character)
            output = true
        } else {
            print("You already selected this character, please choose another one")
            output = false
        }
        return output
    }
    
    func characterAlreadyPresent(character: Character) -> Bool { // Returns true if character has already been selected in characters.
        var output = false
        for element in self.characters {
            if element.id == character.id {
                output = true
                break
            } else {
                output = false && output
            }
        }
        return output
    }
    
    func availableCharacters() -> String { // Returns array of remaining characters selectable by player.
        var available : [Character] = Characters.allCharacters
        available.removeAll(where: {self.characterAlreadyPresent(character: $0)})
        var output : String = ""
        for character in available {
            if character.id == available.last?.id {
                output = output + String(character.id)
            } else {
                output = output + String(character.id) + ", "
            }
        }
        return "(" + output + "): "
    }
    
    func renameCharacter(id: Int, name: String){ // Returns true if player can use that name.
        for i in characters.indices {
            if characters[i].id == id {
                characters[i].name = name
            }
        }
    }
    
    func showTeam() {
        print("\(self.name)")
            for character in self.characters {
                Characters.showCharacter(character)
            }
    }
}
