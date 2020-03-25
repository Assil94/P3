//
//  Colonel.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class Colonel: Character {
    init() {
        let weapon = Glock()
        super.init(name: "Colonel", weapon: weapon)
    }
}
