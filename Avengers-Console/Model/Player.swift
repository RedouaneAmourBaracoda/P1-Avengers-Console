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
    var isAlive : Bool { playerAlive() }
    
    
    // MARK: - init()
    
    init(name: String) {
        self.name = name
    }
    
    
    // MARK: - Player MainFight
    
    func selectAttackingCharacter(){
        Constant.selectCharacterForAttacking(name)
        print(availableCharactersForFight())
        currentCharacter = nil
        while currentCharacter == nil {
            do {
                try selectCharacterForFight()
                guard let safeCurrentCharacter = currentCharacter else { return Constant.printError()}
                Constant.playerSelected(name, safeCurrentCharacter.name)
            } catch UserInput.InvalidSelection.outOfBounds {
                youMustSelectValidCharacter(.outOfBounds, availableCharactersForFight)
            } catch UserInput.InvalidSelection.characterIsDead {
                youMustSelectValidCharacter(.characterIsDead, availableCharactersForFight)
            } catch {
                Constant.printError()
            }
        }
    }
    
    func selectCharacterToHeal(){
        Constant.selectCharacterToHeal(name)
        print(availableCharactersForFight())
        currentCharacter = nil
        while currentCharacter == nil {
            do {
                try selectCharacterForFight()
                guard let safeCurrentCharacter = currentCharacter else { return Constant.printError()}
                Constant.playerSelected(name, safeCurrentCharacter.name)
            } catch UserInput.InvalidSelection.outOfBounds {
                youMustSelectValidCharacter(.outOfBounds, availableCharactersForFight)
            } catch UserInput.InvalidSelection.characterIsDead {
                youMustSelectValidCharacter(.characterIsDead, availableCharactersForFight)
            } catch {
                Constant.printError()
            }
        }
    }
    
    func selectCharacterToBeAttacked() {
        currentCharacter = nil
        while currentCharacter == nil {
            do {
                try selectCharacterForFight()
            } catch UserInput.InvalidSelection.outOfBounds {
                youMustSelectValidCharacter(.outOfBounds, availableCharactersForFight)
            } catch UserInput.InvalidSelection.characterIsDead {
                youMustSelectValidCharacter(.characterIsDead, availableCharactersForFight)
            } catch {
                Constant.printError()
            }
        }
    }

    
    func attack(_ target: Player){
        guard let targetBeforeAttack = target.currentCharacter, let _ = currentCharacter
        else { return print(Constant.thereWasAnErrorWhilleAttacking) }
        target.currentCharacter?.decreaseLife(by: (currentCharacter?.weapon.strengh)!)
        Constant.showWhatHappened(self, targetBeforeAttack, target)
        target.updateCharacter()
    }
    
    func playerAlive() -> Bool { // Character is dead if no more characters or only a doctor remains.
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
            }))
            {
                output = false
            }
        }
        return output
    }
    
    func heal() {
        guard let life = self.currentCharacter?.life
        else { return print(Constant.thereWasAnErrorWhilleAttacking) }
        if life == Characters.maxLife {
            print(self.currentCharacter!.name, "is already doing well ✅ with a life of", self.currentCharacter!.life, "life points ")
        } else if life < Characters.maxLife && life > Characters.maxLife - Characters.doctorStrange.weapon.strengh {
            self.currentCharacter?.life = Characters.maxLife
            print(self.currentCharacter!.name, "was healed 🚑 and now has a life of", self.currentCharacter!.life, "life points ")
        } else {
            self.currentCharacter?.life += Characters.doctorStrange.weapon.strengh
            print(self.currentCharacter!.name, "was healed 🚑 and now has a life of", self.currentCharacter!.life, "life points ")
        }
        updateCharacter()
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
            do {
                if let validSelection = try selectCharacterForInitialization() {
                    addCharacter(validSelection)
                    renameCharacter(id: validSelection.id)
                    guard let currentCharacter else { return Constant.printError()}
                    Game.allCharacters.append(currentCharacter)
                    Constant.displayCharacterSelected()
                    Characters.showCharacter(currentCharacter)
                    Constant.skipLines(1)
                    Constant.hitEnterToContinue()
                    
                }
            } catch UserInput.InvalidSelection.outOfBounds {
                youMustSelectValidCharacter(.outOfBounds, availableCharactersForInitialization)
            } catch UserInput.InvalidSelection.alreadySelected {
                youMustSelectValidCharacter(.alreadySelected, availableCharactersForInitialization)
            } catch {
                Constant.printError()
            }
        }
        Constant.displayTeamComplete(player: self)
        showTeam()
        Constant.hitEnterToContinue()
        Constant.skipLines(20)
    }

    func addCharacter(_ character: Character){
        if  self.characters.count < Player.maxCharactersPerTeam {
            characters.append(character)
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
//            Constant.skipLines(1)
            for i in characters.indices {
                if characters[i].id == id {
                    characters[i].renamed(newName)
                    currentCharacter = characters[i]
                }
            }
        }
        return output
    }
    
    private func nameAlreadyExists(name: String) -> Bool { // Returns true if name already exists in Game.allCharacters
        var output = false
        for element in Game.allCharacters {
            let alreadyExist =
            element.name.localizedStandardContains(name) ||
            element.name.localizedStandardContains(name.uppercased()) ||
            element.name.localizedStandardContains(name.lowercased())
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
        print("\(self.name)")
            for character in self.characters {
                Characters.showCharacter(character)
            }
    }
}


// MARK: - extension for characters selection.

extension Player {
    
    static let maxCharactersPerTeam = 3

    enum UserInput {
        case valid
        case invalid(InvalidSelection)
        
        enum InvalidSelection: Error {
            case outOfBounds
            case alreadySelected
            case characterIsDead
        }
    }
    
    private func selectCharacterForInitialization() throws -> Character? {
        var output : Character?
        var selectedNumber : UserInput = .invalid(.outOfBounds)
            showCurrentSelectionStep()
            if let selectedCharacter = readLine() {
                let selectedCharacterId = Int(selectedCharacter)
                for character in Characters.allCharacters {
                    if selectedCharacterId == character.id {
                        if !characterAlreadyPresent(character: character) {
                            selectedNumber = .valid
                            output = character
                        } else {
                            selectedNumber = .invalid(.alreadySelected)
                        }
                        break
                    }
                }
                switch selectedNumber {
                case .valid :
                    break
                case .invalid(.outOfBounds):
                    throw UserInput.InvalidSelection.outOfBounds
                case .invalid(.alreadySelected):
                    throw UserInput.InvalidSelection.alreadySelected
                case .invalid(.characterIsDead):
                    throw UserInput.InvalidSelection.characterIsDead
                }
            }
        return output
    }
    
    private func selectCharacterForFight() throws {
        var selectedNumber : UserInput = .invalid(.outOfBounds)
            if let selectedCharacter = readLine() {
                let selectedCharacterId = Int(selectedCharacter)
                for character in characters {
                    if selectedCharacterId == character.id {
                        if !character.isDead {
                            self.currentCharacter = character
                            selectedNumber = .valid
                        } else {
                            selectedNumber = .invalid(.characterIsDead)
                        }
                        break
                    }
                }
                switch selectedNumber {
                case .valid :
                    break
                case .invalid(.outOfBounds):
                    throw UserInput.InvalidSelection.outOfBounds
                case .invalid(.alreadySelected):
                    throw UserInput.InvalidSelection.alreadySelected
                case .invalid(.characterIsDead):
                    throw UserInput.InvalidSelection.characterIsDead
                }
            }
    }
    
    private func youMustSelectValidCharacter(_ invalidNumber: UserInput.InvalidSelection, _ availableCharacters: () -> String){
        let string = availableCharacters()
        switch invalidNumber {
        case .characterIsDead :
            Constant.characterIsDead()
            print(string, terminator: "")
        case .outOfBounds:
            Constant.characterOutOfBounds()
            print(string, terminator: "")
        case .alreadySelected:
            Constant.characterAlreadySelected()
        }
    }
    
    func availableCharactersForFight() -> String {
        let characters = self.characters
        var string = "("
        var aliveCharacter : [Character] = []
        for character in characters {
            if !character.isDead {
                aliveCharacter.append(character)
            }
        }
        for character in aliveCharacter {
            if character.id == aliveCharacter.last?.id {
                string.append(String(character.id) + ")")
            } else {
                string.append(String(character.id) + ", ")
            }
        }
        return (string + ": ")
    }
    
    private func availableCharactersForInitialization() -> String { // Returns array of remaining characters selectable by player at initialization.
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
    
    private func showCurrentSelectionStep(){
        switch self.characters.count {
        case 0:
            print(" \(self.name)", Constant.selectYourFirstCharacter, self.availableCharactersForInitialization(), terminator: "" )
        case 1:
            print(" \(self.name)", Constant.selectYourSecondCharacter, self.availableCharactersForInitialization(), terminator: "")
        case 2:
            print(" \(self.name)", Constant.selectYourThirdCharacter, self.availableCharactersForInitialization(), terminator: "")
        default: Constant.printError()
        }
    }

}
