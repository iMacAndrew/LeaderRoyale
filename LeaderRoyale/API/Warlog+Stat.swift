//
//  Warlog+Stat.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/11/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

extension Warlog {

    func didParticipate(playerTag: String) -> Bool {
        return getParticipant(for: playerTag) != nil
    }

    func countPlayerWarWins(playerTag: String) -> Int {
        return getParticipant(for: playerTag)?.wins ?? 0
    }

    func countBattlesPlayed(playerTag: String) -> Int {
        return getParticipant(for: playerTag)?.battlesPlayed ?? 0
    }

    func getParticipant(for playerTag: String) -> Participant? {
        for participant in participants {
            if participant.tag == playerTag {
                return participant
            }
        }

        return nil
    }

    func getStanding(for clanTag: String) -> Standing? {
        for standing in standings {
            if standing.tag == clanTag {
                return standing
            }
        }
        return nil
    }
}
