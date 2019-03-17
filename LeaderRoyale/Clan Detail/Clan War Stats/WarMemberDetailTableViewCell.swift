//
//  WarMemberDetailTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/15/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class WarMemberDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var memberNameLabel: UILabel!
    @IBOutlet weak var warsParticipatedInLabel: UILabel!
    @IBOutlet weak var totalWarsWonLabel: UILabel!


    func configure(with memberInfo: ClanInfo.Member, clan: Clan) {
        memberNameLabel.text = memberInfo.name

        if let playerTag = memberInfo.tag {
            warsParticipatedInLabel.text = "Participated in " +
                String(clan.countWarsParticipated(playerTag: playerTag)) +
                "/" + String(clan.warLogs.count) + " Wars"


            if clan.calcWinPercentage(playerTag: playerTag) > 0.50 {
                totalWarsWonLabel.textColor = .green
            } else {
                totalWarsWonLabel.textColor = .red
            }

            if clan.calcWarParticipationPercentage(playerTag: playerTag) > 0.50 {
                warsParticipatedInLabel.textColor = .green
            } else {
                warsParticipatedInLabel.textColor = .red
            }

            totalWarsWonLabel.text = "Won " + String(clan.countWarWins(playerTag: playerTag)) +
                "/" + String(clan.countBattlesPlayed(playerTag: playerTag)) + " Battles"

        }
        decorateCell()
    }

    func decorateCell() {
        backgroundColor = .dark
        memberNameLabel.textColor = .white
    }
    
}
