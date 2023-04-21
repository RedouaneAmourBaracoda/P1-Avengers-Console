//
//  Character.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

enum Role {
    case attacker
    case healer
}

struct Weapon {
    let name: String
    let strengh: Float
    let emoji: String
}

struct Character { // modification des proprietes ici : single responsability.
    // pourquoi utiliser des variables statiques.
    var name: String // var because of rename function.
    var life: Float
    let role: Role
    var isDead: Bool {
        if life <= 0.0 {
            return true
        } else {
            return false
        }
    }
    let weapon: Weapon
    let description: String
    let id: Int
    
    init(name: String, life: Float, role: Role, weapon: Weapon, image: String, description: String, id: Int) {
        self.name = name
        self.life = life
        self.role = role
        self.weapon = weapon
        self.description = description
        self.id = id
    }
    
    mutating func renamed(_ newName: String) {
        self.name = newName
    }
    
    mutating func decreaseLife(by weaponStrengh: Float){
        self.life -= weaponStrengh
    }
    
    mutating func die(){
        if self.isDead {
            Constant.characterGotKilled(name)
            self.name = Constant.skull
            self.life = 0.0
        }
    }
}
