//
//  Player.swift
//  P3
//
//  Created by Assil Heddar on 09/03/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class Player {
    var namePlayer1 = " "
    var namePlayer2 = " "
    static var firstTeam: [Character] = []
    static var secondTeam: [Character] = []
    var premierCombattant: Character
    var secondCombattant: Character
    init(premierCombattant: Character, secondCombattant: Character) {
        self.premierCombattant = premierCombattant
        self.secondCombattant = secondCombattant
    }
    convenience init () {
        self.init(premierCombattant: Recruit(), secondCombattant: Recruit())
    }
    
    func removeCharacterIfDead(in team: [Character]) -> [Character] {
        var team = team
        for (index, character) in team.enumerated() {
            if character.lifePoints == 0 {
                team.remove(at: index)
                break
            }
        }
        return team
    }
}
