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
    let name : String
    
    init(name: String) {
        self.name = name
    }

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
        return "(" + output + ")"
    }
    
    func renameCharacter(id: Int, name: String){ // Returns true if player can use that name.
        for i in characters.indices {
            if characters[i].id == id {
                characters[i].name = name
            }
        }
    }
    
    func showTeam() {
        print("\(self.name) ", Constant.thisIsYourTeam)
            for character in self.characters {
                Characters.showCharacter(character)
            }
    }

}
