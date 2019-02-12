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
    let trophies: Int?
    let rank: Int?
    let arena: Arena?
    let clan: Clan?
    let stats: Stats?
    let games: Games?
    let leagueStatistics: LeagueStatistics?
    let deckLink: String?
    let currentDeck: [Card]?
    let cards: [Card]?
    let achievements: [Achievement]?
    
}

extension PlayerInfo {
    struct Arena: Decodable {
        let name: String?
        let arena: String?
        let arenaID: Int?
        let trophyLimit: Int?
    }
    
    struct Clan: Decodable {
        let tag: String?
        let name: String?
        let role: String?
        let donations: Int?
        let donationsReceived: Int?
        let donationsDelta: Int?
        let badge: Badge?
        
        struct Badge: Decodable {
            let name: String?
            let category: String?
            let id: Int?
            let image: String?
        }
    }
    
    struct Stats: Decodable {
        let clanCardsCollected: Int?
        let tournamentCardsWon: Int?
        let maxTrophies: Int?
        let threeCrownWins: Int?
        let cardsFound: Int?
        let favoriteCard: Card?
        let totalDonations: Int?
        let challengeMaxWins: Int?
        let challengeCardsWon: Int?
        let level: Int?
    }
    
    struct Games: Decodable {
        let total: Int?
        let tournamentGames: Int?
        let wins: Int?
        let warDayWins: Int?
        let winsPercent: Double?
        let losses: Int?
        let lossesPercent: Double?
        let draws: Int?
        let drawsPercent: Double?
    }
    
    struct Card: Decodable {
        let name: String?
        let level: Int?
        let count: Int?
        let requiredForUpgrade: StringOrInt?
        let leftToUpgrade: Int?
        let id: Int?
        let maxLevel: Int?
        let icon: String?
        let key: String?
        let elixir: Int?
        let type: String?
        let rarity: String?
        let arena: Int?
        let description: String?
    }
    
    struct LeagueStatistics: Decodable {
        let currentSeason: CurrrentSeason?
        let previousSeason: PreviousSeason?
        let bestSeason: BestSeason?
        
        struct CurrrentSeason: Decodable {
            let id: String?
            let trophies: Int?
            let bestTrophies: Int?
        }
        
        struct PreviousSeason: Decodable {
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
    
    struct Achievement: Decodable {
        let name: String?
        let stars: Int?
        let value: Int?
        let target: Int?
        let info: String?
    }
    
}


