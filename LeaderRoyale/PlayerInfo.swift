//
//  PlayerInfo.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/25/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import Foundation

struct PlayerInfo: Decodable {
    let tag: String?
    let name: String?
    let expLevel: Int?
    let trophies: Int?
    let bestTrophies: Int?
    let wins: Int?
    let losses: Int?
    let battleCount: Int?
    let threeCrownWins: Int?
    let challengeCardsWon: Int?
    let challengeMaxWins: Int?
    let tournamentCardsWon: Int?
    let tournamentBattleCount: Int?
    let role: String?
    let donations: Int?
    let donationsReceived: Int?
    let totalDonations: Int?
    let warDayWins: Int?
    let clanCardsCollected: Int?
    
}

extension PlayerInfo {
    struct Arena: Decodable {
        let id: Int?
        let name: String?
    }
    
    struct Clan: Decodable {
        let tag: String?
        let name: String?
        let badgeId: Int?
    }
    
    struct LeagueStatistics: Decodable {
        
    }
    
    struct Achievements: Decodable {
        let name: String?
        let stars: Int?
        let value: Int?
        let target: Int?
        let info: String?
    }
    
    struct Cards: Decodable {
        let name: String?
        let level: Int?
        let maxLevel: Int?
        let count: Int?
    }
    
    struct CurrentFavoriteCards: Decodable {
        let name: String?
        let id: Int?
        let maxLevel: Int?
    }
    
}

extension PlayerInfo.LeagueStatistics {
    struct CurrrentSeason: Decodable {
        let id: String?
        let trophies: Int?
        let bestTrophies: Int?
    }
    
    struct PreciousSeason: Decodable {
        let id: String?
        let trophies: Int?
        let bestTrophies: Int?
    }
    
    struct BestSeason: Decodable {
        let id: String?
        let trophies: Int?
        let bestTrophies: Int?
    }
}

extension PlayerInfo.Cards {
    struct iconUrls: Decodable {
        let medium: String?
    }
}

extension PlayerInfo.CurrentFavoriteCards {
    struct iconUrls: Decodable {
        let medium: String?
    }
}
