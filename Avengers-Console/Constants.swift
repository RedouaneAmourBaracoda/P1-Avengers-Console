//
//  Constants.swift
//  Avengers-Console
//
//  Created by Redouane on 31/03/2023.
//

import Foundation

struct Constant {
    static let welcome = """




Welcome to the Avengers game. In this game, there will be two players, each one needs to select 3 characters among the list below: \n



"""
    
    static func hitEnterToContinue() {
        print("Hit enter to continue. "); let _ = readLine()
    }
    
    static let thisIsYourTeam = " This is your team : \n"
    
    static let selectYourFirstCharacter = " please select your first character with valid number"
    
    static let selectYourSecondCharacter = " please select your second character with valid number. \nRemember characters must be different. Available characters"
    
    static let selectYourThirdCharacter = " please select your third and last character with valid number. \nRemember this character is the last one and must be also different from others. Available characters"
    
    static let youMustSelectValidNumber = " You must enter a whole number between 1 and 4 "
    
    static let renameThisCharacter = "Rename this character : "
    
    static let sorryThisNameIsNonValid = "❌ sorry this name is either non-valid or already taken, pick something else: "
    
    static func printError() {
        print("Sorry, there has been an error occuring ...")
    }
}
