//
//  President.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class President: Character {
    init() {
        let weapon = Rocket()
        super.init(name: "Président", weapon: weapon)
    }
}
