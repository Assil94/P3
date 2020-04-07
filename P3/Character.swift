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
    convenience init() {
        self.init(name: "Hello", weapon: Rocket())
    }
    func presentation() {
        print("Je suis \(name), j'ai \(lifePoints) de point vie. Je suis equipé de \(weapon.name) qui fait \(weapon.dammage) de degâts.")
    }
    // Cette méthode est là pour afficher les personnages disponibles.
    static func completePresentation() {
        print("Les Personnages disponibles sont :")
        for character in Character.characterList {
            character.presentation()
        }
    }
    // Liste des personnages
    static func listTeam(player: Player) -> [Character] {
        print("La liste des personnages et statistiques de l'équipe de \(player.name).")
        for character in player.team {
            print("Je suis \(character.name), il me reste \(character.lifePoints) et je suis équipé de \(character.weapon).")
        }
        return player.team
    }
    // Pour eviter qu'un personnage dessende en dessous de 0 pv
   static func regulateAndResult(character: Character) {
           if character.lifePoints < 0 {
               character.lifePoints = 0
               print("Ce personnage est mort.")
           }
           print("Les points de vie de \(character.name) sont de: \(character.lifePoints).")
       }
}
