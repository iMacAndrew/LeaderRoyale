//
//  Recognition.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

struct Recognition: CustomStringConvertible {
    let title: String
    let playerName: String
    let stat: String
    let isGood: Bool?

    var description: String {
        if isGood == true {
            return "Congrats to \(playerName) for \(title) this week with \(stat) 🤯 Powered by Leader Royale."
        } else if isGood == false {
            return "Boo \(playerName) for \(title) this week with \(stat) 🤨 Powered by Leader Royale."
        } else {
            return "\(playerName) had \(title) this week with \(stat) 🤓 Powered by Leader Royale."
        }
    }
}
