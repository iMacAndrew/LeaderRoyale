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

        var battlesLoss = participantInfo.battlesPlayed - participantInfo.wins

        participantNameLabel.text = participantInfo.name
        cardsCollectedLabel.text = "\(participantInfo.cardsEarned) Cards Collected"
        battlesWonLabel.text = "Won \(participantInfo.wins) / \(participantInfo.battlesPlayed) Battles"

        if participantInfo.battlesPlayed == 0  {
            battlesWonLabel.text = "Skipped Battle Day"
        }

       

        var didWin: Bool

        decorateCellOriginal()

        if participantInfo.wins > 0 && participantInfo.battlesPlayed > 0 {
            didWin = true
            decorateCell(didWin: didWin)
        }
        else if participantInfo.wins == 0 && participantInfo.battlesPlayed > 0 {
            didWin = false
            decorateCell(didWin: didWin)
        }


    }

    private func decorateCell(didWin: Bool) {
        if didWin {
            battlesWonLabel.textColor = .green
        } else {
            battlesWonLabel.textColor = .red
        }

    }

    private func decorateCellOriginal() {
        backgroundColor = .dark
        participantNameLabel.textColor = .white
        cardsCollectedLabel.textColor = .white
        battlesWonLabel.textColor = .white
    }

}

