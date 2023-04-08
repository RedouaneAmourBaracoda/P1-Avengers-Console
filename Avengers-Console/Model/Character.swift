//
//  Character.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

struct Character {
    var name: String
    var life: Float
    var isDead: Bool {
        if life <= 0.0 {
            return true
        } else {
            return false
        }
    }
    var weapon: Weapon
    let image : String
    var description: String
    let id: Int
    
    init(name: String, life: Float, weapon: Weapon, image: String, description: String, id: Int) {
        self.name = name
        self.life = life
        self.weapon = weapon
        self.image = image
        self.description = description
        self.id = id
    }
    
    mutating func renameCharacter(_ rename: String){
        self.name = rename
    }
    
    mutating func die(){
        if self.isDead {
            print("☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️  \(self.name) is now dead. ☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️")
            self.description = "☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️"
            self.name += " ☠️☠️☠️☠️☠️☠️☠️☠️"
            self.life = 0.0
            self.weapon.strengh = 0.0
            self.weapon.name = "☠️☠️☠️☠️☠️☠️☠️"
            self.weapon.emoji = "☠️☠️☠️☠️☠️☠️☠️"
        }
    }
}

struct Weapon {
    var name: String
    var strengh: Float
    var emoji: String
}

//******************************* Model d'initialisation des 4 personnages *************************************

enum Characters: CaseIterable {
    case captain
    case thor
    case thanos
    case doctorStrange
    
    static func displayAllPossibleCharacters(){
        for character in allCharacters {
            showCharacter(character)
        }
    }
    
    static func showCharacter(_ character: Character) {
        print(
            "-- \(character.id): \(character.name), ",
            "life: \(character.life), ",
            "weapon: \(character.weapon.name) \(character.weapon.emoji) with", "strengh: \(character.weapon.strengh), ",
            "description: \(character.description)\n"
            )
    }
    
    static let allCharacters = Characters.startGame()
    
    static func startGame() -> [Character]{
            var characters : [Character] = []
            for character in Characters.allCases {
                characters.append(character.character)
            }
            return characters
    }
    
    var character: Character {
        switch self {
        case .captain:
            return Character(name: Characters.captain.name, life: Characters.captain.startingLife, weapon: Characters.captain.weapon, image: Characters.captain.image, description: Characters.captain.description, id: Characters.captain.id)
        case .thor:
            return Character(name: Characters.thor.name, life: Characters.thor.startingLife, weapon: Characters.thor.weapon, image: Characters.thor.image, description: Characters.thor.description, id: Characters.thor.id)
        case .thanos:
            return Character(name: Characters.thanos.name, life: Characters.thanos.startingLife, weapon: Characters.thanos.weapon, image: Characters.thanos.image, description: Characters.thanos.description, id: Characters.thanos.id)
        case .doctorStrange:
            return Character(name: Characters.doctorStrange.name, life: Characters.doctorStrange.startingLife, weapon: Characters.doctorStrange.weapon, image: Characters.doctorStrange.image, description: Characters.doctorStrange.description, id: Characters.doctorStrange.id)
        }
    }
    
    var name: String {
        switch self {
        case .captain:
            return "Captain"
        case .thor:
            return "Thor"
        case .thanos:
            return "Thanos"
        case .doctorStrange:
            return "Doctor strange"
        }
    }
    
    var id: Int {
        switch self {
        case .captain:
            return 1
        case .thor:
            return 2
        case .thanos:
            return 3
        case .doctorStrange:
            return 4
        }
    }
    
    var image: String {
        switch self {
        case .captain:
            return "Captain"
        case .thor:
            return "Thor"
        case .thanos:
            return "Thanos"
        case .doctorStrange:
            return "Doctor-strange"
        }
    }
    
    var description: String {
        switch self {
        case .captain:
            return "Thoughest defender with a strongly resistent shield."
        case .thor:
            return "Thunder master with powerful Hammer strike."
        case .thanos:
            return "Thanos is the most dangerous evil creature ever made."
        case .doctorStrange:
            return "Greatest healing power, ability to resuscitate."
        }
    }
    
    var startingLife: Float {
        switch self {
        case .captain:
            return 50.0
        case .thor:
            return 45.0
        case .thanos:
            return 40.0
        case .doctorStrange:
            return 90.0
        }
    }
    
    var weapon: Weapon {
        switch self {
        case .captain:
            return Weapon(name: "Shield", strengh: 50.0, emoji: "🛡️")
        case .thor:
            return Weapon(name: "Thunder", strengh: 60.0, emoji: "⚡️")
        case .thanos:
            return Weapon(name: "Ring", strengh: 70.0, emoji: "💍")
        case .doctorStrange:
            return Weapon(name: "Apple care", strengh: 20.0, emoji: "🚑")
        }
    }
}

