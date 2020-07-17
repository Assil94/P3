//
//  Character.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation


class Character {
    static var characterList = [Soldier(), Officier(), Recruit(), Chief(), Colonel(), President()]
    var weapon: Weapon
    var lifePoints = 100
    let name: String
    
    init(name: String, weapon: Weapon) {
        self.name = name
        self.weapon = weapon
    }
    
    private func presentation() {
        print("I am \(name), i have \(lifePoints) HP. My weapon is \(weapon.name) and deals \(weapon.dammage) dammages.")
    }
    // This method display characters available.
    static func completePresentation() {
        print("Characters available are :")
        for character in Character.characterList {
            character.presentation()
        }
    }
    // Shows character list.
    static func listTeam(player: Player) -> [Character] {
        print("The list of characters and team statistics of \(player.name).")
        for character in player.team {
            print("I am \(character.name), I have left \(character.lifePoints) and I am equipped with \(character.weapon.name).")
        }
        return player.team
    }
    // To prevent a character from falling below 0 hp.
    static func regulateAndResult(character: Character) {
        if character.lifePoints < 0 {
            character.lifePoints = 0
            print("This character is dead.")
        }
        print("The life points of \(character.name) are equal to: \(character.lifePoints).")
    }
    // This method change the weapon randomly
    func changeWeaponRandomly() {
        let randomNumber = Int.random(in: 1...2)
        if randomNumber == 1 {
            weapon = Flamethrower()
            print("A chest has appeared, it contains a new weapon which is \(weapon.name).")
        }
    }
}
