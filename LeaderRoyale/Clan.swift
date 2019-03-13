//
//  Clan.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 2/1/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

struct Clan: Codable {
    let clanInfo: ClanInfo
    let players: [PlayerInfo]
    let warLogs: [Warlog]
}
