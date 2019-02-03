//
//  PlayerProfileStatsTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 2/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class PlayerProfileStatsTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var playerWinsLabel: UILabel!
    
    var memberInfo: ClanInfo.Member?
    var playerInfo: PlayerInfo?
        
    func configure(section: Sections, playerInfo: PlayerInfo) {
        
        sectionTitle.text = section.title
        
        if let playerWins = playerInfo.games?.wins {
            playerWinsLabel.text = String(playerWins)
        }
        
    }
    
}
