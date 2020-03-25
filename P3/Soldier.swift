//
//  Soldier.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class Soldier: Character {
    init() {
        let weapon = Scarh()
        super.init(name: "Soldat", weapon: weapon)
    }
}
