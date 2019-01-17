//
//  ClanInfoMember+Stats.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

extension ClanInfo.Member {
    
    var roleAsInt: Int {
        guard let role = role?.lowercased().trimmingCharacters(in: .whitespaces) else {
            return 0
        }
        if role == "leader" {
            return 3
        }
        else if role == "coleader" {
            return 2
        }
        else if role == "elder" {
            return 1
        }
        else if role == "member" {
            return 0
        } else {
            return 0
        }
    }
    
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
