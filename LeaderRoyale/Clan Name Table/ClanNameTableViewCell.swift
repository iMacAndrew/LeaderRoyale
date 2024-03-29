//
//  ClanNameTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ClanNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clanNameLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var clanLogo: UIImageView!

    func configure(with clanInfo: ClanInfo?) {
        if let clanName = clanInfo?.name {
            clanNameLabel.text = String(clanName)
        } else {
            clanNameLabel.text = ""
        }
        
        if let memberCount = clanInfo?.memberCount {
            memberCountLabel.text = String(memberCount)
        } else {
            memberCountLabel.text = ""
        }
        
        
        if let imageUrl = clanInfo?.badge?.image {
            ImageManager.getImage(url: imageUrl) { (url, image) in
                DispatchQueue.main.async {
                    self.clanLogo.image = image
                }
            }
               
        }
        
    }
    
}
