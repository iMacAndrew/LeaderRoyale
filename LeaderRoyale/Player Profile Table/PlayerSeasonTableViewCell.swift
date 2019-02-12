//
//  PlayerSeasonTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 2/12/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class PlayerSeasonTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func configure(section: Sections, playerInfo: PlayerInfo) {
        titleLabel.text = section.title
        decorateCell()
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        titleLabel.textColor = .white
        
    }
    
}
