//
//  CharacterFactory.swift
//  Avengers-Console
//
//  Created by Redouane on 21/04/2023.
//

import Foundation

enum Characters: CaseIterable { 
    case captain
    case thor
    case thanos
    case doctorStrange
    
    static let maxLife: Float = 100.0
    
    static func displayAllPossibleCharacters(){
        print(Constant.list)
        for character in allCharacters {
            showCharacter(character)
        }
        Constant.skipLines(1)
    }
    
    static func showCharacter(_ character: Character) {
        print(
            "  -- \(character.id): \(character.name), ",
            "life: \(character.life), ",
            "weapon: \(character.weapon.name) \(character.weapon.emoji) with", "strengh: \(character.weapon.strengh), ",
            "description: \(character.description)"
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
            return Character(name: Characters.captain.name, life: Characters.captain.startingLife, role: Characters.captain.role , weapon: Characters.captain.weapon, image: Characters.captain.image, description: Characters.captain.description, id: Characters.captain.id)
        case .thor:
            return Character(name: Characters.thor.name, life: Characters.thor.startingLife, role: Characters.thor.role, weapon: Characters.thor.weapon, image: Characters.thor.image, description: Characters.thor.description, id: Characters.thor.id)
        case .thanos:
            return Character(name: Characters.thanos.name, life: Characters.thanos.startingLife, role: Characters.thanos.role , weapon: Characters.thanos.weapon, image: Characters.thanos.image, description: Characters.thanos.description, id: Characters.thanos.id)
        case .doctorStrange:
            return Character(name: Characters.doctorStrange.name, life: Characters.doctorStrange.startingLife, role: Characters.doctorStrange.role, weapon: Characters.doctorStrange.weapon, image: Characters.doctorStrange.image, description: Characters.doctorStrange.description, id: Characters.doctorStrange.id)
        }
    }
    
    var role : Role {
        switch self {
        case .captain: return .attacker
        case .thor: return .attacker
        case .thanos: return .attacker
        case .doctorStrange: return .healer
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
            return "Greatest healing power, ability to boost life up."
        }
    }
    
    var startingLife: Float {
        switch self {
        case .captain:
            return 55.0
        case .thor:
            return 50.0
        case .thanos:
            return 45.0
        case .doctorStrange:
            return 90.0
        }
    }
    
    var weapon: Weapon {
        switch self {
        case .captain:
            return Weapon(name: "Shield", strengh: 30.0, emoji: "🛡️")
        case .thor:
            return Weapon(name: "Thunder", strengh: 45.0, emoji: "⚡️")
        case .thanos:
            return Weapon(name: "Ring", strengh: 55.0, emoji: "💍")
        case .doctorStrange:
            return Weapon(name: "Care", strengh: 30.0, emoji: "🚑")
        }
    }
}
