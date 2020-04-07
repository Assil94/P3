//
//  Player.swift
//  P3
//
//  Created by Assil Heddar on 09/03/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

var firstTeam: [Character] = []
var secondTeam: [Character] = []

class Player {
    var name = ""
    var teamLifePoints = 300
    var team: [Character] = []
    
    func selectCharacter() {
        for (index, character) in team.enumerated() {
            let number = index + 1
            let name = character.name
            if character.lifePoints > 0 {
                print("pour \(name) Tapez \(number)")
            }
        }
    }
    
    func makeTeam() -> [Character] {
        print("Ok \(name) constitues ton équipe."
            +  "\n Tapez 1 pour Soldier \n Tapez 2 pour Officier"
            + "\n Tapez 3 pour Recruit \n Tapez 4 pour Chef \n Tapez 5 pour Colonel \n Tapez 6 pour Président")        
        while team.count < 3 {
            if let choice = readLine() {
                if let index = Int(choice), index <= 6 {
                    let number = index - 1
                    print("Vous avez choisis le personnage \(Character.characterList[number].name), choisissez un autre personnage.")
                    team.append(Character.characterList[number])
                } else {
                    print("Recommencez")
                    return makeTeam()
                }
            }
        }
        print("Bravo \(name) tu as 3 personnages :), voici ton équipe.")
        for character in team {
            print(character.name)
        }
        return team
    }
    
    func removeLifePoints(dammage: Int, index: Int) {
        let character = team[index]
        if dammage >= character.lifePoints {
            teamLifePoints -= character.lifePoints
        } else {
            teamLifePoints -= dammage
        }
        character.lifePoints -= dammage
    }
    
    func takeDammage(dammage: Int, defender: Player) {
        print("Qui voulez-vous attaquer ?")
        defender.selectCharacter()
        if let choice = readLine() {
            if let index = Int(choice), index <= 3 {
                let number = index - 1
                print("Vous avez selectionné \(defender.team[number].name) à attaquer.")
                defender.removeLifePoints(dammage: dammage, index: number)
                Character.regulateAndResult(character: defender.team[number])
            } else {
                print("Erreur dans votre selection.")
                return takeDammage(dammage: dammage, defender: defender)
            }
        }
        print("Votre équipe a \(defender.teamLifePoints) points de vie.")
    }
    
    func healing(for character: Character, player: Player) {
        character.lifePoints += 25
        player.teamLifePoints += 25
        if player.teamLifePoints > 300 {
            player.teamLifePoints = 300
        }
        if character.lifePoints > 100 {
            character.lifePoints = 100
        }
        print("Ton personnage \(character.name) a maintenant \(character.lifePoints).")
    }
}
