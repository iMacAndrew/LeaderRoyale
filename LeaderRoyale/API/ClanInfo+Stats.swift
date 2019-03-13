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

    var memberThatClimbedTheLeastRanks: Member? {
        guard let members = members else { return nil }
        guard var leastRanksClimber = members.first else { return nil }

        for member in members {
            if member.ranksClimbed < leastRanksClimber.ranksClimbed {
                leastRanksClimber = member
            }
        }
        return leastRanksClimber
    }
    
    var memberWithHighestDonationRatio: Member? {
        guard let members = members else { return nil }
        guard var memberBestDonationRatio = members.first else { return nil }
        
        for member in members {
            if member.donationRatio > memberBestDonationRatio.donationRatio {
                memberBestDonationRatio = member
            }
        }
        
        return memberBestDonationRatio
    }

    var memberWithLowestDonationRatio: Member? {
        guard let members = members else { return nil }
        guard var memberLowestDonationRatio = members.first else { return nil }

        for member in members {
            if member.donationRatio <= memberLowestDonationRatio.donationRatio {
                memberLowestDonationRatio = member
            }
        }

        return memberLowestDonationRatio
    }

    var memberPercentages: Double {
        
        guard let members = members else { return 0.0 }
        
        let totalMembers = members.count - 1
        var memberRoleCount = 0
        
        for member in members {
            if member.role == "member" {
                memberRoleCount += 1
            }
        }
        let totalMemberPercentage = (Double(memberRoleCount) / Double(totalMembers)) * 100
        return Double(round(totalMemberPercentage * 10) / 10)
    }
    
    var coLeaderPercentages: Double {
        
        guard let members = members else { return 0.0 }
        
        let totalMembers = members.count - 1
        var coLeaderRoleCount = 0
        
        for member in members {
            if member.role == "coLeader" {
                coLeaderRoleCount += 1
            }
        }
        let totalCoLeaderPercentage = (Double(coLeaderRoleCount) / Double(totalMembers)) * 100
        return Double(round(totalCoLeaderPercentage * 10) / 10)
    }
    
    var elderPercentages: Double {
        
        guard let members = members else { return 0.0 }
        
        let totalMembers = members.count - 1
        var elderRoleCount = 0
        
        for member in members {
            if member.role == "elder" {
                elderRoleCount += 1
            }
        }
        let totalElderPercentage = (Double(elderRoleCount) / Double(totalMembers)) * 100
        return Double(round(totalElderPercentage * 10) / 10)
    }
    
    var countMembers: Int {
        
        guard let members = members else { return 0 }
        
        var memberRoleCount = 0
        
        for member in members {
            if member.role == "member" {
                memberRoleCount += 1
            }
        }
        
        return memberRoleCount
    }
    
    var countElders: Int {
        
        guard let members = members else { return 0 }
        
        var elderRoleCount = 0
        
        for member in members {
            if member.role == "elder" {
                elderRoleCount += 1
            }
        }
        
        return elderRoleCount
    }
    
    var countCoLeaders: Int {
        
        guard let members = members else { return 0 }
        
        var coLeaderRoleCount = 0
        
        for member in members {
            if member.role == "coLeader" {
                coLeaderRoleCount += 1
            }
        }
        
        return coLeaderRoleCount
    }
    
    var averageDonation: Double {
        guard let members = members else { return 0.0 }
        
        var totalDonationCount = 0
        
        for member in members {
            
            if let donations = member.donations {
                totalDonationCount += donations
            }
        }
        let averageDonations = Double(totalDonationCount) / Double(members.count)
        return Double(round(averageDonations))
    }
    
    var averageKingLevel: Double {
        
        guard let members = members else { return 0.0 }
        var totalKingLevelCount = 0
        
        for member in members {
            if let memberKingLevel = member.expLevel {
                totalKingLevelCount += memberKingLevel
            }
        }
        
        let averageKingLevel = Double(totalKingLevelCount) / Double(members.count)
        
        return round(averageKingLevel * 10) / 10
    }
    
    var returnPlayerTags: [String] {
        
        guard let members = members else { return []}
        
        var completePlayerTags = [String]()
        
        for member in members {
            
            if let playerTag = member.tag {
                completePlayerTags.append(playerTag)
            }
        }
        
        return completePlayerTags
        
    }
    
//    var activityLevel: Int {
//        
//    }
    
}
