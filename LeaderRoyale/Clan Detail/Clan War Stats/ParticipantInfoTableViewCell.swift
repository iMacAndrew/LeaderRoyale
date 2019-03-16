//
//  ParticipantInfoTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/12/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ParticipantInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var participantNameLabel: UILabel!
    @IBOutlet weak var cardsCollectedLabel: UILabel!
    @IBOutlet weak var battlesWonLabel: UILabel!

    func configure(with participantInfo: Warlog.Participant?) {

        guard let participantInfo = participantInfo else {
            return
        }

        participantNameLabel.text = participantInfo.name
        cardsCollectedLabel.text = "\(participantInfo.cardsEarned) Cards Collected"

        decorateCellOriginal()

        if participantInfo.battlesPlayed == 1 && participantInfo.wins == 1 {
            battlesWonLabel.text = "Won"
            battlesWonLabel.textColor = .green
        }
        else if participantInfo.battlesPlayed == 1 && participantInfo.wins == 0 {
            battlesWonLabel.text = "Lost"
            battlesWonLabel.textColor = .red
        }
        else if participantInfo.battlesPlayed == 0  {
            battlesWonLabel.text = "Missed Battle Day"
            battlesWonLabel.textColor = .red
            participantNameLabel.textColor = .red
        } else {
            battlesWonLabel.text = "Won \(participantInfo.wins) / \(participantInfo.battlesPlayed) Battles"
        }

    }


    private func decorateCellOriginal() {
        backgroundColor = .dark
        participantNameLabel.textColor = .white
        cardsCollectedLabel.textColor = .white
        battlesWonLabel.textColor = .white
    }

}

