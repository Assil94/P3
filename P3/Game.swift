//
//  Game.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class Game {
    // initialization of the properties which will serve us for the game.
    private var round = 0
    private let player1 = Player()
    private let player2 = Player()
    // The start method allows you to ask players for their names and prepare for the game.
     func start() {
        print("Welcome to the two players who will compete! Player 1, choose a name." )
        if let namePlayer1 = readLine() {
            let trimmed = namePlayer1.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty {
                print("Enter something.")
                start()
            } else {
                player1.name = namePlayer1
                print("You are \(namePlayer1). \n1 Now player 2 choose a name.")
                if let namePlayer2 = readLine() {
                    let trimmed = namePlayer2.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmed.isEmpty {
                        print("Enter something.")
                        start()
                    } else if namePlayer1 == namePlayer2 {
                        print("You can't have the same name.")
                        start()
                    } else {
                        player2.name = namePlayer2
                        print("You are \(namePlayer2).")
                        Character.completePresentation()
                        player1.team = player1.makeTeam()
                        player2.team = player2.makeTeam()
                        makeBattle()
                    }
                }
            }
        }
    }
    // This method continue the battle while any player gets 0 health point.
    private func makeBattle() {
        while player1.teamLifePoints > 0 && player2.teamLifePoints > 0 {
            player1.team = turn(attacker: player1, defender: player2)
            player2.team = turn(attacker: player2, defender: player1)
            round += 1
        }
        whoWon()
    }
    // This method defined the turns..
    private func turn(attacker: Player, defender: Player) -> [Character] {
        print("The battle starts, \(attacker.name) vs \(defender.name). \n \(attacker.name) to treat type 1. \n for attack type 2.")
        if let choice = readLine() {
            if Int(choice) == 1 {
                print("Choose a character to treat.")
                attacker.selectCharacter()
                if let choice = readLine() {
                    if let choosenNumber = Int(choice), choosenNumber <= 3 {
                        let number = choosenNumber - 1
                        if attacker.team[number].lifePoints <= 0 {
                            print("Choose an other character")
                            return turn(attacker: attacker, defender: defender)
                        }
                        print("You selected \(attacker.team[number]) to be treated.")
                        attacker.healing(for: attacker.team[number], player: attacker)
                    } else {
                        print("Error in your selection.")
                        return turn(attacker: attacker, defender: defender)
                    }
                }
            } else if Int(choice) == 2 {
                attacker.selectCharacter()
                if let choice = readLine() {
                    if let choosenNumber = Int(choice), choosenNumber <= 3 {
                        let indexCharacter = choosenNumber - 1
                        if attacker.team[indexCharacter].lifePoints <= 0 {
                            print("Choose an other character")
                            return turn(attacker: attacker, defender: defender)
                        }
                        print("You selected \(attacker.team[indexCharacter].name) to battle.")
                        attacker.team[indexCharacter].changeWeaponRandomly()
                        attacker.takeDammage(indexCharacter: indexCharacter, defender: defender)
                    } else {
                        print("Error in your selection.")
                        return turn(attacker: attacker, defender: defender)
                    }
                }
            } else {
                return turn(attacker: attacker, defender: defender)
            }
        }
        return attacker.team
    }
    // This method display the statistics of the game.
    private func whoWon() {
        if player1.teamLifePoints > player2.teamLifePoints {
            print("\(player1.name) won !! Congrats, \(player2.name) Take a revange.")
        } else {
            print("\(player2.name) won !! Félicitation, \(player1.name) Take a revange.")
        }
        print("The game had \(round) turns.")
        player1.team = Character.listTeam(player: player1)
        player2.team = Character.listTeam(player: player2)
    }
}
