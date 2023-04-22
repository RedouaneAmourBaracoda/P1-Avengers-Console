//
//  Constants.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

public struct Constant {
    
    static func hitEnterToContinue() {
        skipLines(1)
        print("                                           ⤷ 🔵 Hit enter to continue 🔵 ⤶"); let _ = readLine()
    }
    
    static func skipLines(_ lines: Int){
        for _ in 1...lines {
            print("\n")
        }
    }
    
    static func characterGotKilled(_ name: String) {
        print("☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️  \(name) is now dead. ☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️")

    }
    
    static func showWhatHappened(_ attacker: Player, _ target: Player) {
        skipLines(2)
        print("     💥BIM!  ....   💥BAAAAAAAM!     ....    💥BOOM!  ")
        print(" 🛂", attacker.currentCharacter!.name, "used his", attacker.currentCharacter!.weapon.name, attacker.currentCharacter!.weapon.emoji, "to attack", target.currentCharacter!.name, "who has lost", attacker.currentCharacter!.weapon.strengh, "life points. ")
    }

    static func characterOutOfBounds() {
        print(" You can only select valid character -> ", terminator: "")
    }
    
    static func characterAlreadySelected(){
        print(Constant.youAlreadySelectedThisCharacter, terminator: "")
    }
    
    static func characterIsDead() {
        print("🪦 Sorry this character is not alive anymore 🪦. May he rest in peace 👼🏻.", terminator: "")
        print(" You can only select alive character -> ", terminator: "")
    }
    
    static func playerSelected(_ playerName: String, _ characterName: String){
        print(" 🛂 \(playerName) selected \(characterName) ✅. ", terminator: "")
    }
    
    static func selectCharacterToHeal(_ name: String) {
        print("\(name)", Constant.selectCharacterToHeal, terminator: "")
    }
    
    static func selectCharacterForAttacking(_ name: String){
        print("\(name)", Constant.selectCharacterForAttacking, terminator: "")
    }
    
    static func displayTeamComplete(player: Player){
        skipLines(20)
        print("                            ✅ \(player.name) congratulations, your team is complete ✅  ")
    }
    
    static func displayCharacterSelected() {
        print(" ✅ Character chosen: ")
    }
    
    static func displayGameRecap(){
        skipLines(20)
        print("                                              🛂  GAME RECAP ")
    }
    
    static func playerBecomesTheWinner(_ player: Player, _ rounds: Int){
        print(" 🛂 🏆 \(player.name) BECOMES THE WINNER AFTER \(rounds) ROUNDS 🏆")
    }
    
    static func displayChooseCharacterInOtherTeam(_ player: Player) {
        print(" 🛂",player.name, "now choose a character to attack in other team ? ")
        skipLines(2)
    }
    
    static func displayGameOver() {
        print("                                              🛂   GAME OVER.\n")
        print("\n")
    }
    
    static func displayRounds(_ round: Int) {
        print("------------------------------------------------ 🥊 ROUND \(round) 🥊---------------------------------------------\n")
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
    
    static let skull = "☠️☠️☠️☠️☠️☠️☠️"
    
    static let renameThisCharacter = " 🛂 Rename this character : "
    
    static let player1Name = "Team 1"
    
    static let player2Name = "Team 2"
    
    static let thisIsYourTeam = " This is your team : \n"
    
    static let selectYourFirstCharacter = " please select your character n°1️⃣ with valid number"
    
    static let selectYourSecondCharacter = " please select your character n°2️⃣ with valid number. Remember characters must be different. Available characters"
    
    static let selectYourThirdCharacter = " please select your character n°3️⃣. Available characters"
    
    static let youMustSelectValidNumber = " You must enter a valid number. Available characters -> "
    
    static let sorryThisNameIsNonValid = "❌ sorry this name is either non-valid or already taken, pick something else: "
    
    static let youAlreadySelectedThisCharacter = "You already selected this character, please choose another one. "
    
    static func printError() {
        print("Sorry, there has been an error occuring ...")
    }
    
    static let selectCharacterForAttacking = "select a character for attacking "
    
    static let selectCharacterToHeal = "select a character to heal: "
    
    static let thereWasAnErrorWhilleAttacking = "there was an error while attacking: one of the players has his current character not initialized."
    
    static let welcome = """




Welcome to the Avengers game. In this game, there will be two players, each one needs to select 3 characters among the list below : \n



"""
}
