//
//  Officier.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class Officier: Character {
    init() {
        let weapon = MP45()
        super.init(name: "Commandant", weapon: weapon)
    }
}
