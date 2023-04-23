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
    var name: String
    let strengh: Float
    var emoji: String
}

// Note: attributes declared as variables because of rename() and die() functions.
struct Character {
    var name: String
    var life: Float
    let role: Role
    var isDead: Bool {
        if life <= 0.0 {
            return true
        } else {
            return false
        }
    }
    var weapon: Weapon
    var description: String
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
    
    mutating func die(){ // When character is dead, we want to replace all atributes by 💀
        if self.isDead {
            Constant.characterGotKilled(name)
            self.name = Constant.skull
            self.life = 0.0
            self.weapon.name = Constant.skull
            self.weapon.emoji = Constant.skull
            self.description = Constant.skull
            
        } else {
            Constant.remainingLife(self)
        }
    }
    
    mutating func decreaseLife(by weaponStrengh: Float){
        self.life -= weaponStrengh
    }
    
    mutating func increaseLife(){ // Character life cannot exceed 100.0.
        let initialLife = life
        Constant.skipLines(1)
        if life == Characters.maxLife {
            print(name, "is already doing well ✅ with a life of", life, "life points ")
        } else if life < Characters.maxLife && life > Characters.maxLife - Characters.doctorStrange.weapon.strengh {
            life =  Characters.maxLife
            print(" 💬" , name, "initially had \(initialLife) life points but was healed 🚑 by doctor who provided +30 life points.")
            print(" 💬 Life cannot exceed 100.0.", terminator: "")
        } else {
            life += Characters.doctorStrange.weapon.strengh
            print(" 💬", name, "initially had \(initialLife) life points but was healed 🚑 by doctor who provided +30 life points.", terminator: "")
        }
    }
}
