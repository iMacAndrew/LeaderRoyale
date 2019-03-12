//
//  ClanInfo.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/18/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import Foundation

struct ClanInfo: Codable {
    let tag: String?
    let name: String?
    let description: String?
    let type: String?
    let score: Int?
    let memberCount: Int?
    let requiredScore: Int?
    let donations: Int?
    let clanChest: ClanChest?
    let badge: Badge?
    let members: [Member]?
    let location: Location?
}

extension ClanInfo {
    struct ClanChest: Codable {
        let status: String?
    }
}

extension ClanInfo {
    struct Badge: Codable {
        let name: String?
        let category: String?
        let id: Int?
        let image: String?
    }
}

extension ClanInfo {
    struct Location: Codable {
        let name: String?
        let isCountry: Bool?
        let code: String?
    }
    
    struct Member: Codable {
        let name: String?
        let tag: String?
        let rank: Int?
        let previousRank: Int?
        let role: String?
        let expLevel: Int?
        let trophies: Int?
        let clanChestCrowns: Int?
        let donations: Int?
        let donationsReceived: Int?
        let donationsDelta: Int?
        let donationsPercent: Double?
        let arena: Arena?
    }
}

extension ClanInfo.Member {
    struct Arena: Codable {
        let arenaID: Int?
        let arena: String?
        let name: String?
        let trophyLimit: Int?
    }
}
