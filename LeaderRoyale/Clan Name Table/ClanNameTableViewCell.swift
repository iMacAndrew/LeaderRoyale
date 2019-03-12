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
    @IBOutlet weak var clanTagLabel: UILabel!
    @IBOutlet weak var clanScoreLabel: UILabel!
    @IBOutlet weak var clanTrophyWork: UILabel!
    @IBOutlet weak var clanDonationsLabel: UILabel!
    @IBOutlet weak var clanDescriptionLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    func configure(with clanInfo: ClanInfo?) {
        if let clanName = clanInfo?.name {
            clanNameLabel.text = String(clanName)
        } else {
            clanNameLabel.text = ""
        }
        
        if let memberCount = clanInfo?.memberCount {
            memberCountLabel.text = String(memberCount) + "/50 members"
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
        
        if let clanTag = clanInfo?.tag {
            clanTagLabel.text = "#" + clanTag
        }
        
        
        
        if let clanScore = clanInfo?.score {
            clanScoreLabel.text = String(clanScore.withCommas())
        }
        
        if let clanTrophies = clanInfo?.trophies {
            clanTrophyWork.text = String(clanTrophies.withCommas())
        }
        
        if let clanDonations = clanInfo?.donations {
            clanDonationsLabel.text = String(clanDonations.withCommas())
        }
        
        if let clanDescription = clanInfo?.description {
            clanDescriptionLabel.text = clanDescription
        }
        
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
