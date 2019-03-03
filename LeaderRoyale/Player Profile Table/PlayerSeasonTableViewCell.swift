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
    @IBOutlet weak var currentSeasonTrophyLabel: UILabel!
    @IBOutlet weak var previousSeasonTrophyLabel: UILabel!
    @IBOutlet weak var bestSeasonTrophyLabel: UILabel!
    
    
    func configure(section: Sections, playerInfo: PlayerInfo) {
        titleLabel.text = section.title
        
        if let currentSeasonBestTrophy = playerInfo.leagueStatistics?.currentSeason?.bestTrophies {
            currentSeasonTrophyLabel.text = String(currentSeasonBestTrophy)
        }
        
        if let previousSeasonBestTrophy = playerInfo.leagueStatistics?.previousSeason?.bestTrophies {
            previousSeasonTrophyLabel.text = String(previousSeasonBestTrophy)
        }
        
        if let bestSeasonBestTrophy = playerInfo.leagueStatistics?.bestSeason?.bestTrophies {
            bestSeasonTrophyLabel.text = String(bestSeasonBestTrophy)
        }
        decorateCell()
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        titleLabel.textColor = .white
        bestSeasonTrophyLabel.textColor = .white
        currentSeasonTrophyLabel.textColor = .white
    
        previousSeasonTrophyLabel.textColor = .white
        
    }
    
}
