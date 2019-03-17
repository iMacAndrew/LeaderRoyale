//
//  Clan.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 2/1/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

struct Clan: Codable {
    let clanInfo: ClanInfo
    let players: [PlayerInfo]
    let warLogs: [Warlog]

    func countWarsParticipated(playerTag: String) -> Int {
        var numberOfWarsParticipatedIn: Int = 0

        for warLog in warLogs {
            if warLog.didParticipate(playerTag: playerTag) {
                numberOfWarsParticipatedIn += 1
            }
        }

        return numberOfWarsParticipatedIn
    }

    func countWarWins(playerTag: String) -> Int {
        var totalWarWins: Int = 0

        for warLog in warLogs {
            totalWarWins += warLog.playerWarWins(playerTag: playerTag)
        }

        return totalWarWins
    }

    func countBattlesPlayed(playerTag: String) -> Int {
        var totalBattlesPlayed: Int = 0

        for warLog in warLogs {
            totalBattlesPlayed += warLog.battlesPlayed(playerTag: playerTag)
        }

        return totalBattlesPlayed
    }

    func countBattlesLost(playerTag: String) -> Int {
        var totalBattlesLost: Int = 0

        for warLog in warLogs {
            totalBattlesLost += warLog.battlesLost(playerTag: playerTag)
        }

        return totalBattlesLost
    }

    func countCardsEarned(playerTag: String) -> Int {
        var totalCardsEarned: Int = 0

        for warLog in warLogs {
            totalCardsEarned += warLog.cardsEarned(playerTag: playerTag)
        }

        return totalCardsEarned
    }

    func totalTrophiesChanged() -> Int {

        guard let clanTag = clanInfo.tag else {
            return 0
        }

        var totalTrophiesChanged: Int = 0

        for warLog in warLogs {
            totalTrophiesChanged += warLog.warTrophiesChanged(clanTag: clanTag)
        }

        return totalTrophiesChanged
    }

    func calcWinPercentage(playerTag: String) -> Double {
        if countWarWins(playerTag: playerTag) == 0 && countBattlesPlayed(playerTag: playerTag) == 0 {
            return 0.0
        } else {
            return Double(countWarWins(playerTag: playerTag)) / Double(countBattlesPlayed(playerTag: playerTag))
        }
    }

    func calcWarParticipationPercentage(playerTag: String) -> Double {
        return Double(countWarsParticipated(playerTag: playerTag)) / Double(warLogs.count)
    }


    var playerWithMostWarDayWins: PlayerInfo? {
        guard var topPlayer = players.first, let topPlayerTag = topPlayer.tag else {
            return nil
        }
        var topPlayersWinCount = countWarWins(playerTag: topPlayerTag)

        for player in players {
            if let playerTag = player.tag {
                let newPlayerWarWins = countWarWins(playerTag: playerTag)
                if newPlayerWarWins > topPlayersWinCount {
                    topPlayer = player
                    topPlayersWinCount = newPlayerWarWins
                }
            }
        }
        return topPlayer
    }

    var playerWithMostWarDayLosses: PlayerInfo? {
        guard var worstPlayer = players.first, let worstPlayerTag = worstPlayer.tag else {
            return nil
        }
        var worstPlayerLossCount = countBattlesLost(playerTag: worstPlayerTag)

        for player in players {
            if let playerTag = player.tag {
                let newPlayerLosses = countBattlesLost(playerTag: playerTag)

                if newPlayerLosses >= worstPlayerLossCount {
                    worstPlayer = player
                    worstPlayerLossCount = newPlayerLosses
                }
            }
        }
        return worstPlayer
    }

    var playerWithMostCardsEarned: PlayerInfo? {
        guard var topPlayer = players.first, let topPlayerTag = topPlayer.tag else {
            return nil
        }
        var topPlayersCardsEarned = countCardsEarned(playerTag: topPlayerTag)

        for player in players {
            if let playerTag = player.tag {
                let newPlayerCardEarned = countCardsEarned(playerTag: playerTag)
                if newPlayerCardEarned > topPlayersCardsEarned {
                    topPlayer = player
                    topPlayersCardsEarned = newPlayerCardEarned
                }
            }
        }
        return topPlayer
    }

}


