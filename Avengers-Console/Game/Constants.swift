//
//  Constants.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

public struct Constant {
    
    static func hitEnterToContinue() {
        print("Hit enter to continue. "); let _ = readLine()
    }
    
    static func skipLines(_ lines: Int){
        for _ in 1...lines {
            print("\n")
            print("\n")
        }
    }
    
    static func displayGameRecap(){
        print("\n")
        print("\n")
        print("\n")
        print("                                                         🛂  GAME RECAP ")
        print("\n")
    }
    
    static func playerBecomesTheWinner(_ player: Player, _ rounds: Int){
        print(" 🛂 🏆 \(player.name) BECOMES THE WINNER AFTER \(rounds) ROUNDS 🏆")
    }
    
    static func displayChooseCharacterInOtherTeam(_ player: Player) {
        print(" 🛂",player.name, "choose a character to attack in other team ?\n")
    }
    
    static func displayGameOver() {
        print("                                                    🛂   GAME OVER.\n")
        print("\n")
    }
    
    static func displayRounds(_ round: Int) {
        print("------------------------------------------------------------- 🥊 ROUND \(round) 🥊 --------------------------------------------------------------\n")
    }
    
    static func displayFirstAttacker (_ player: Player) {
        print(" 🛂 \(player.name) you have been designated to start attacking. ", terminator: "")
    }
    
    static func displaySwapPlayer(_ player: Player){
        print(" 🛂 \(player.name) becomes now attacking team. ", terminator: "")
    }
    
    static func displayRenameCharacter() {
        print(Constant.renameThisCharacter, terminator: "")
    }
    
    static let renameThisCharacter = "Rename this character : "
    
    static let player1Name = "Team 1"
    
    static let player2Name = "Team 2"
    
    static let thisIsYourTeam = " This is your team : \n"
    
    static let selectYourFirstCharacter = " please select your first character with valid number"
    
    static let selectYourSecondCharacter = " please select your second character with valid number. \nRemember characters must be different. Available characters"
    
    static let selectYourThirdCharacter = " please select your third and last character with valid number. \nRemember this character is the last one and must be also different from others. Available characters"
    
    static let youMustSelectValidNumber = " You must enter a whole number between 1 and 4 "
    
    static let sorryThisNameIsNonValid = "❌ sorry this name is either non-valid or already taken, pick something else: "
    
    static let youAlreadySelectedThisCharacter = "You already selected this character, please choose another one" 
    
    static func printError() {
        print("Sorry, there has been an error occuring ...")
    }
    
    static let selectCharacterForAttacking = "select a character for attacking: "
    static let selectCharacterToHeal = "select a character to heal: "
    static let thereWasAnErrorWhilleAttacking = "there was an error while attacking: one of the players has his current character not initialized."
    static let welcome = """




Welcome to the Avengers game. In this game, there will be two players, each one needs to select 3 characters among the list below : \n



"""
}
