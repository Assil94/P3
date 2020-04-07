//
//  Game.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class Game {
    // initialisation des propriétés qui vont nous servir pour le jeu.
    var turn = 0
    let player1 = Player()
    let player2 = Player()
    
    // La méthode start permet de demander aux joueurs leur nom et de préparer la partie.
    func start() {
        print("Bienvenue aux deux joueurs qui vont s'affronter ! Joueur 1, choisis un nom." )
        if let namePlayer1 = readLine() {
            let trimmed = namePlayer1.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty {
                print("Entrez quelquechose.")
                start()
            } else {
                player1.name = namePlayer1
                print("Tu es \(namePlayer1). \n1 Au tour du joueur 2 de choisir un nom.")
                if let namePlayer2 = readLine() {
                    let trimmed = namePlayer2.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmed.isEmpty {
                        print("Entrez quelque chose.")
                        start()
                    } else if namePlayer1 == namePlayer2 {
                        print("Vous ne pouvez pas avoir le même nom.")
                        start()
                    } else {
                        player2.name = namePlayer2
                        print("Tu es \(namePlayer2).")
                        Character.completePresentation()
                        firstTeam = player1.makeTeam()
                        secondTeam = player2.makeTeam()
                        makeBattle()
                    }
                }
            }
        }
    }
    
    func makeBattle() {
        while player1.teamLifePoints > 0 && player2.teamLifePoints > 0 {
            firstTeam = turn(attacker: player1, defender: player2)
            secondTeam = turn(attacker: player2, defender: player1)
            turn += 1
        }
        whoWON()
    }
    
    // Cette méthode nous permet determiner le tour de chacun.
    func turn(attacker: Player, defender: Player) -> [Character] {
        print("place au combat, \(attacker.name) vs \(defender.name). \n \(attacker.name) pour soigner tapes 1. \n Pour attaquer tapes 2.")
        if let choice = readLine() {
            if Int(choice) == 1 {
                print("Choisis un personnage a soigner.")
                attacker.selectCharacter()
                if let choice = readLine() {
                    if let index = Int(choice), index <= 3 {
                        let number = index - 1
                        print("Vous avez selectionné \(attacker.team[number]) pour être soigné.")
                        attacker.healing(for: attacker.team[number], player: attacker)
                    } else {
                        print("Erreur dans votre selection.")
                        return turn(attacker: attacker, defender: defender)
                    }
                }
            }
            else if Int(choice) == 2 {
                attacker.selectCharacter()
                if let choice = readLine() {
                    if let index = Int(choice), index <= 3 {
                        let number = index - 1
                        print("Vous avez selectionné \(attacker.team[number].name) pour combattre.")
                        attacker.takeDammage(dammage: attacker.team[number].weapon.dammage, defender: defender)
                    } else {
                        print("Erreur dans votre selection.")
                        return turn(attacker: attacker, defender: defender)
                    }
                }
            } else { return turn(attacker: attacker, defender: defender)
            }
        }
        return attacker.team
    }
    
    // Cette méthode affiche les statistiques de la partie.
    func whoWON() {
        if player1.teamLifePoints > player2.teamLifePoints {
            print("\(player1.name) à gagné !! Felicitions, \(player2.name) ce n'est pas grave retente t'as chance")
        } else {
            print("\(player2.name) à gagné !! Felicitions, \(player1.name) ce n'est pas grave retente t'as chance")
        }
        print("Il y a eu \(turn) tour")
        firstTeam = Character.listTeam(player: player1)
        secondTeam = Character.listTeam(player: player2)
    }
}
