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
    @IBOutlet weak var averageElixerLabel: UILabel!
    @IBOutlet weak var copyDeckButton: UIButton!

    private var playerInfo: PlayerInfo?

    @IBAction func pushedCopyButton(_ sender: Any) {
        if let deckLink = playerInfo?.deckLink, let url = URL(string: deckLink) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        copyDeckButton.imageView?.contentMode = .scaleAspectFit
    }

    func configure(section: Sections, playerInfo: PlayerInfo?) {

        self.playerInfo = playerInfo

        sectionTitle.text = section.title
        
        setCardImages(playerInfo: playerInfo)
        
        let averageElixer = getAverageElixer(playerInfo: playerInfo)
        
        averageElixerLabel.text = String(averageElixer)
        
        decorateCell()
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
    
    func getAverageElixer(playerInfo: PlayerInfo?) -> Double {
        
        guard let currentDeck = playerInfo?.currentDeck else {
            return 0.0
        }
        
        var totalElixir = 0
        
        for card in currentDeck {
            
            if let elixir = card.elixir {
                totalElixir += elixir
            }
            
        }
        
        let averageElixir = Double(totalElixir) / Double(currentDeck.count)
        
        return averageElixir
        
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        sectionTitle.textColor = .white
        averageElixerLabel.textColor = .white
    }
    
}
