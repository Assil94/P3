//
//  Player.swift
//  P3
//
//  Created by Assil Heddar on 09/03/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation


class Player {
    var name = ""
    var teamLifePoints = 300
    var team: [Character] = []
    // This method allows us to select a character.
    func selectCharacter() {
        for (index, character) in team.enumerated() {
            let number = index + 1
            let name = character.name
            if character.lifePoints > 0 {
                print("for \(name) type \(number)")
            }
        }
    }
    // Method allowing to compose a team.
    func makeTeam() -> [Character] {
        print("Ok \(name) make your team.")
        while team.count < 3 {
            for (index, character) in Character.characterList.enumerated() {
                let number = index + 1
                let name = character.name
                print("for \(name) type \(number)")
            }
            if let choice = readLine() {
                if let index = Int(choice), index <= Character.characterList.count {
                    let number = index - 1
                    print("You chose the character \(Character.characterList[number].name), choose another character.")
                    team.append(Character.characterList[number])
                    Character.characterList.remove(at: number)
                } else {
                    print("Restart")
                    return makeTeam()
                }
            }
        }
        print("Congrats! \(name) you have 3 character :), here is your team.")
        for character in team {
            print(character.name)
        }
        return team
    }
    // Method for removing a character's hit points.
    private func removeLifePoints(dammage: Int, index: Int) {
        let character = team[index]
        if dammage >= character.lifePoints {
            teamLifePoints -= character.lifePoints
        } else {
            teamLifePoints -= dammage
        }
        character.lifePoints -= dammage
    }
    // Method for inflicting damage on a character..
    func takeDammage(indexCharacter: Int, defender: Player) {
        print("Who do you want to attack?")
        let dammage = team[indexCharacter].weapon.dammage
        defender.selectCharacter()
        if let choice = readLine() {
            if let index = Int(choice), index <= 3 {
                let number = index - 1
                print("You have selected \(defender.team[number].name) to attack.")
                defender.removeLifePoints(dammage: dammage, index: number)
                Character.regulateAndResult(character: defender.team[number])
            } else {
                print("Error in your selection.")
                return takeDammage(indexCharacter: indexCharacter, defender: defender)
            }
        }
        print("Your team have \(defender.teamLifePoints) health point.")
    }
    // Method for treating a character.
    func healing(for character: Character, player: Player) {
        character.lifePoints += 25
        player.teamLifePoints += 25
        if player.teamLifePoints > 300 {
            player.teamLifePoints = 300
        }
        if character.lifePoints > 100 {
            character.lifePoints = 100
        }
        print("Your character \(character.name) now have \(character.lifePoints) health point.")
    }
}
