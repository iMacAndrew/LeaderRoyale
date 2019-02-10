//
//  PlayerDeckTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 2/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class PlayerDeckTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet var cardImageViews: [UIImageView]!
    
    
    func configure(section: Sections, playerInfo: PlayerInfo?) {
        sectionTitle.text = section.title
        
        setCardImages(playerInfo: playerInfo)
        
        
    }
    
    func setCardImages(playerInfo: PlayerInfo?) {
        
        guard let currentDeck = playerInfo?.currentDeck else {
            return
        }
        
        for i in 0..<currentDeck.count {
            
            if let cardIconUrl = currentDeck[i].icon {
                ImageManager.getImage(url: cardIconUrl) { (_, cardImage) in
                    guard self.cardImageViews.indices.contains(i) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.cardImageViews[i].image = cardImage
                    }
                    
                }
            }
            
            
        }
    }
    
}
