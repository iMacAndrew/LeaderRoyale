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
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    func configure(recognition: Recognition) {
        titleLabel.text = recognition.title
        subTitleLabel.text = recognition.subTitle
        playerNameLabel.text = recognition.playerName
        statLabel.text = recognition.stat
        
        decorateCell()
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        titleLabel.textColor = UIColor.white
        subTitleLabel.textColor = UIColor.white
        playerNameLabel.textColor = UIColor.white
        statLabel.textColor = UIColor.white
    }
    
}
