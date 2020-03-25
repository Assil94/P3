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
        print("Je suis \(name), j'ai \(lifePoints) de point vie. Je suis equipé de \(weapon) qui fait \(weapon.dammage) de degât")
    }
}
