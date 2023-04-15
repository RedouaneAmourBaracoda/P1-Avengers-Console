//
//  Player.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

final class Player {
    
    // MARK: - Player properties
    
    let id = UUID()
    let name : String
    var characters : [Character] = []
    var currentCharacter: Character?
    var isAlive : Bool {
        var output = true
        if characters.count == Player.maxCharactersPerTeam {
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
    
    
    
    // MARK: - init()
    
    init(name: String) {
        self.name = name
    }
    
    
    // MARK: - Player MainFight
    
    func selectAttackingCharacter(){
        print("\(self.name)", Constant.selectCharacterForAttacking, terminator: "")
        self.selectCharacterForMainFight()
        if let safeCurrentCharacter = self.currentCharacter {
            print(" 👉🏻 \(self.name) selected \(safeCurrentCharacter.name).")
            print("\n")
        }
    }
    
    func attack(_ player: Player){
        guard let _ = player.currentCharacter, let _ = self.currentCharacter else { return
            print(Constant.thereWasAnErrorWhilleAttacking)
        }
        player.currentCharacter?.decreaseLife(by: (self.currentCharacter?.weapon.strengh)!)
        print("👉🏻", self.currentCharacter!.name, "used his", self.currentCharacter!.weapon.name, self.currentCharacter!.weapon.emoji, "to attack", player.currentCharacter!.name, "who has lost", self.currentCharacter!.weapon.strengh, "life points. ")
        player.updateCharacter()
    }
    
    func selectCharacterToHeal(){
        print("\(self.name)", Constant.selectCharacterToHeal, terminator: "")
        self.selectCharacterForMainFight()
        self.heal()
        self.updateCharacter()
    }
    
    private func heal() {
        guard let life = self.currentCharacter?.life  else { return
            print(Constant.thereWasAnErrorWhilleAttacking)
        }
        if life == Characters.maxLife {
            print(self.currentCharacter!.name, "is already doing well ✅ with a life of", self.currentCharacter!.life, "life points ")
        } else if life < Characters.maxLife && life > Characters.maxLife - Characters.doctorStrange.weapon.strengh {
            self.currentCharacter?.life = Characters.maxLife
            print(self.currentCharacter!.name, "was healed 🚑 and now has a life of", self.currentCharacter!.life, "life points ")
        } else {
            self.currentCharacter?.life += Characters.doctorStrange.weapon.strengh
            print(self.currentCharacter!.name, "was healed 🚑 and now has a life of", self.currentCharacter!.life, "life points ")
        }
    }
    
    func updateCharacter(){
        guard let safeCharacter = currentCharacter, characters.count > 0 else { return Constant.printError()}
        for index in 0...characters.count - 1 {
            if safeCharacter.id == characters[index].id {
                characters[index] = safeCharacter
                characters[index].die() // Only if no more life.
            }
        }
    }

    // MARK: - Player initialization
    
    
    func makeTeam(){
        while characters.count < Player.maxCharactersPerTeam {
            selectCharacterForInitialization()
        }
    }
    private func selectCharacterForInitialization(){
        var validNumber: Bool = false
        repeat {
            showCurrentSelectionStep()
            if let selectedCharacter = readLine() {
                let selectedCharacterId = Int(selectedCharacter)
                switch selectedCharacterId {
                case Characters.captain.id:
                    addCharacter(Characters.captain.character)
                    validNumber = true
                case Characters.thor.id:
                    addCharacter(Characters.thor.character)
                    validNumber = true
                case Characters.thanos.id:
                    addCharacter(Characters.thanos.character)
                    validNumber = true
                case Characters.doctorStrange.id :
                    addCharacter(Characters.doctorStrange.character)
                    validNumber = true
                default:
                    print(Constant.youMustSelectValidNumber)
                    validNumber = false
                }
            }
        } while !validNumber
    }

    func addCharacter(_ character: Character){
        if  self.characters.count < Player.maxCharactersPerTeam && !characterAlreadyPresent(character: character){
            characters.append(character)
            renameCharacter(id: character.id)
        } else {
            print(Constant.youAlreadySelectedThisCharacter)
        }
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
    
    func renameCharacter(id: Int){
        Constant.displayRenameCharacter()
        if var newName = readLine() {
            while !canRenameCharacter(with: id, newName) || newName == "" {
                print(Constant.sorryThisNameIsNonValid, terminator: "")
                newName = readLine() ?? ""
            }
        }
    }
    
    private func canRenameCharacter(with id: Int, _ newName: String) -> Bool {
        var output : Bool = false
        if !nameAlreadyExists(name: newName) {
            output = true
            Constant.skipLines(1)
            for i in characters.indices {
                if characters[i].id == id {
                    characters[i].renamed(newName)
                    Game.allCharacters.append(characters[i])
                    Characters.showCharacter(characters[i])
                }
            }
        }
        return output
    }
    
    private func nameAlreadyExists(name: String) -> Bool { // Returns true if name already exists in Game.allCharacters
        var output = false
        for element in Game.allCharacters {
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
    
    func showCurrentSelectionStep(){
        switch self.characters.count {
        case 0:
            print("\(self.name)", Constant.selectYourFirstCharacter, self.availableCharacters(), terminator: "" )
        case 1: print("\(self.name)", Constant.selectYourSecondCharacter, self.availableCharacters(), terminator: "")
        case 2: print("\(self.name)", Constant.selectYourThirdCharacter, self.availableCharacters(), terminator: "")
        default: Constant.printError()
        }
    }
    
    func availableCharacters() -> String { // Returns array of remaining characters selectable by player at initialization. 
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
    
    func showTeam() {
        print("\(self.name)")
            for character in self.characters {
                Characters.showCharacter(character)
            }
    }
}

extension Player {
    
    static let maxCharactersPerTeam = 3

    enum SelectedNumber: Equatable {
        case valid
        case invalid(InvalidNumber)
        
        enum InvalidNumber {
            case outOfBound
            case characterIsDead
        }
    }
    
    func selectCharacterForMainFight(){
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
    
    
    
    func youMustSelectValidCharacter(_ invalidNumber: SelectedNumber.InvalidNumber){
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

}
