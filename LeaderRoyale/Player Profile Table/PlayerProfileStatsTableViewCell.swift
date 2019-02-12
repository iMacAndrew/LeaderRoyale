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
    @IBOutlet weak var playerThreeCrownWinsLabel: UILabel!
    @IBOutlet weak var playerHighestTrophiesLabel: UILabel!
    @IBOutlet weak var playerCardsFoundLabel: UILabel!
    @IBOutlet weak var playerTotalDonationsLabel: UILabel!
    @IBOutlet weak var playerFavCard: UILabel!
    
    var memberInfo: ClanInfo.Member?
    var playerInfo: PlayerInfo?
        
    func configure(section: Sections, playerInfo: PlayerInfo) {
        
        sectionTitle.text = section.title
        
        if let playerWins = playerInfo.games?.wins {
            playerWinsLabel.text = String(playerWins.withCommas())
        }
        
        if let playerThreeCrownWins = playerInfo.stats?.threeCrownWins {
            playerThreeCrownWinsLabel.text = String(playerThreeCrownWins.withCommas())
        }
        
        if let playerHighestTrophies = playerInfo.stats?.maxTrophies {
            playerHighestTrophiesLabel.text = String(playerHighestTrophies.withCommas())
        }
        
        if let playerCardsFound = playerInfo.stats?.cardsFound {
            playerCardsFoundLabel.text = String(playerCardsFound)
        }
        
        if let playerTotalDonations = playerInfo.stats?.totalDonations {
            playerTotalDonationsLabel.text = String(playerTotalDonations.withCommas())
        }
    
        if let playerFavoriteCard = playerInfo.stats?.favoriteCard?.name {
            playerFavCard.text = playerFavoriteCard
        }
        
        decorateCell()
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        sectionTitle.textColor = .white
        playerWinsLabel.textColor = .white
        playerThreeCrownWinsLabel.textColor = .white
        playerHighestTrophiesLabel.textColor = .white
        playerCardsFoundLabel.textColor = .white
        playerTotalDonationsLabel.textColor = .white
        playerFavCard.textColor = .white
    }
    
}
