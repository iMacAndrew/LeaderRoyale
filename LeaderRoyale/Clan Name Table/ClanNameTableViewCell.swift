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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
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
