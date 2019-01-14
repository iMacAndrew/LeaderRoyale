//
//  ClanInfo+Stats.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

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
            if member.ranksClimbed > mostRanksClimber.ranksClimbed {
                mostRanksClimber = member
            }
        }
        return mostRanksClimber
    }
    
}
