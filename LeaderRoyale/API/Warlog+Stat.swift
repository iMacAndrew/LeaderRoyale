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

    func warTrophiesChanged(clanTag: String) -> Int {

        guard let standing = getStanding(for: clanTag) else {
            return 0
        }

        return standing.warTrophiesChange
    }

    func playerWarWins(playerTag: String) -> Int {
        return getParticipant(for: playerTag)?.wins ?? 0
    }

    func battlesPlayed(playerTag: String) -> Int {
        return getParticipant(for: playerTag)?.battlesPlayed ?? 0
    }

    func battlesLost(playerTag: String) -> Int {
        return battlesPlayed(playerTag: playerTag) - playerWarWins(playerTag: playerTag)
    }

    func cardsEarned(playerTag: String) -> Int {
        return getParticipant(for: playerTag)?.cardsEarned ?? 0
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
