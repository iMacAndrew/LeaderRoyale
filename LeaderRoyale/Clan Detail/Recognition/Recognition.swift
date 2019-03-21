//
//  Recognition.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

struct Recognition {
    let title: String
    let playerName: String
    let stat: String
    let isGood: Bool?

    func description(withPowered: Bool) -> String {
        let result: String
        if isGood == true {
            result = "Congrats to \(playerName) for \(title) this week with \(stat) 🤯"
        } else if isGood == false {
            result = "Boo \(playerName) for \(title) this week with \(stat) 🤨"
        } else {
            result = "\(playerName) had \(title) this week with \(stat) 🤓"
        }

        return result + (withPowered ? " Powered by Leader Royale." : "")
    }

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
