//
//  RecognitionTableViewCell.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class RecognitionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    var recognition: Recognition!
    
    func configure(recognition: Recognition) {
        titleLabel.text = recognition.title
        playerNameLabel.text = recognition.playerName
        statLabel.text = recognition.stat
        self.recognition = recognition
        
        decorateCell()
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        titleLabel.textColor = UIColor.white
        playerNameLabel.textColor = UIColor.white
        statLabel.textColor = UIColor.white
        
        if recognition.isGood == true {
            playerNameLabel.textColor = .green
            statLabel.textColor = .green
        }
        else if recognition.isGood == false {
            playerNameLabel.textColor = .red
            statLabel.textColor = .red
        }
    }
    
}
