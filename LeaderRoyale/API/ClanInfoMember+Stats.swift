//
//  ClanInfoMember+Stats.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

extension ClanInfo.Member {
    
    var ranksClimbed: Int {
        guard let rank = rank, let previousRank = previousRank else {
            return 0
        }
        let totalRanksCLimbed = rank - previousRank
        return totalRanksCLimbed
    }
    
    var donationRatio: Double {
        guard let donations = donations, let donationsReceived = donationsReceived else {
            return 0
        }
        guard donationsReceived != 0 else {
            return Double(donations)
        }
        
        let calcDonationRatio = Double(donations) / Double(donationsReceived)
        
        return calcDonationRatio
        
    }
    
}
