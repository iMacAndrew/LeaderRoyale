//
//  ClanInfo.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/18/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import Foundation

struct ClanInfo: Decodable {
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
    struct ClanChest: Decodable {
        let status: String?
    }
}

extension ClanInfo {
    struct Badge: Decodable {
        let name: String?
        let category: String?
        let id: Int?
        let image: String?
    }
}

extension ClanInfo {
    struct Location: Decodable {
        let name: String?
        let isCountry: Bool?
        let code: String?
    }
    
    struct Member: Decodable {
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
    struct Arena: Decodable {
        let arenaID: Int?
        let arena: String?
        let name: String?
        let trophyLimit: Int?
    }
}

extension ClanInfo {
    var trophies: Int {
        var sumTrophies = 0
        for member in members ?? [] {
            sumTrophies += member.trophies ?? 0
        }
        return sumTrophies
    }
    
    var memberWithMostDonations: Member? {
        guard let members = members else { return nil }
        guard var bestDonator = members.first else { return nil }
        
        for member in members {
            if let memberDonations = member.donations, memberDonations > bestDonator.donations ?? 0 {
                bestDonator = member
            }
        }
        return bestDonator
    }
    
    var memberWithMostDonationsReceived: Member? {
        guard let members = members else { return nil }
        guard var highestReciever = members.first else { return nil }
        
        for member in members {
            if let memberDonationsReceived = member.donationsReceived, memberDonationsReceived > highestReciever.donationsReceived ?? 0 {
                highestReciever = member
            }
        }
        
        return highestReciever
    }
    
    var memberThatClimbedTheMostRanks: Member? {
        guard let members = members else { return nil }
        guard var mostRanksClimber = members.first else { return nil }

        for member in members {
            if let memberRank = member.rank, let memberPreviousRank = member.previousRank {
                let memberRanksClimbed = memberRank - memberPreviousRank
                
                if let bestMemberRank = mostRanksClimber.rank, let bestMemberPreviousRank = mostRanksClimber.previousRank {
                    let bestMemberRanksClimbed = bestMemberRank - bestMemberPreviousRank
                    
                    if memberRanksClimbed > bestMemberRanksClimbed {
                        mostRanksClimber = member
                    }
                    
                } else {
                    mostRanksClimber = member
                }
            }
        }
        
        return mostRanksClimber
    }
    
}
