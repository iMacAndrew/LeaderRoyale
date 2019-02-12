//
//  PlayerGeneralInfoTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 2/9/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class PlayerGeneralInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTagLabel: UILabel!
    @IBOutlet weak var kingLevelLabel: UILabel!
    @IBOutlet weak var playerTrophyLabel: UILabel!
    @IBOutlet weak var clanIconImage: UIImageView!
    @IBOutlet weak var clanNameLabel: UILabel!
    @IBOutlet weak var playerClanScoreLabel: UILabel!
    @IBOutlet weak var arenaImage: UIImageView!
    @IBOutlet weak var playerRoleLabel: UILabel!
    
    func configure(section: Sections, playerInfo: PlayerInfo?) {
        playerNameLabel.text = playerInfo?.name
        playerTagLabel.text = playerInfo?.tag
        
        if let arenaImageUrl = playerInfo?.arena?.arena {
            ImageManager.getImage(url: arenaImageUrl) { (url, image) in
                DispatchQueue.main.async {
                    self.arenaImage.image = image
                }
            }
            
        }
        
        if let playerLevel = playerInfo?.stats?.level {
            kingLevelLabel.text = String(playerLevel)
        }
        
        if let playerTrophies = playerInfo?.trophies {
            playerTrophyLabel.text = String(playerTrophies)
        }
        
        if let clanImageUrl = playerInfo?.clan?.badge?.image {
            ImageManager.getImage(url: clanImageUrl) { (url, image) in
                DispatchQueue.main.async {
                    self.clanIconImage.image = image
                }
            }
            
        }
        
        clanNameLabel.text = playerInfo?.clan?.name
        playerClanScoreLabel.text = "??"
        
        playerRoleLabel.text = playerInfo?.clan?.role
        
        decorateCell()
        
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        playerNameLabel.textColor = .white
        playerTagLabel.textColor = .white
        kingLevelLabel.textColor = .white
        playerTrophyLabel.textColor = .white
        clanNameLabel.textColor = .white
        playerClanScoreLabel.textColor = .white
        playerRoleLabel.textColor = .white
    }
    
    
}
