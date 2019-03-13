//
//  Warlog.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/11/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

struct Warlog: Codable {
    let createdDate: Int
    let participants: [Participant]
    let standings: [Standing]
    let seasonNumber: Int

    struct Participant: Codable {
        let tag: String
        let name: String
        let cardsEarned: Int
        let battlesPlayed: Int
        let wins: Int
    }

    struct Standing: Codable {
        let tag: String
        let name: String
        let participants: Int
        let battlesPlayed: Int
        let wins: Int
        let crowns: Int
        let warTrophies: Int
        let warTrophiesChange: Int
        let badge: Badge

        struct Badge: Codable {
            let name: String
            let category: String
            let id: Int
            let image: String
        }

    }

}
