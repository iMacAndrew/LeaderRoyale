//
//  ClanOverviewTableViewCell.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/12/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ClanOverviewTableViewCell: UITableViewCell {
    @IBOutlet weak var clanLogoImageView: UIImageView!
    @IBOutlet weak var clanTagLabel: UILabel!
    @IBOutlet weak var clanDescriptionTextView: UITextView!
    @IBOutlet weak var clanScoreLabel: UILabel!
    @IBOutlet weak var clanTrophyLabel: UILabel!
    @IBOutlet weak var clanDonationsPerWeekLabel: UILabel!
    
    func configure(with clanInfo: ClanInfo) {
        clanTagLabel.text = clanInfo.tag ?? ""
        clanDescriptionTextView.text = clanInfo.description ?? ""
        clanScoreLabel.text = String(clanInfo.score ?? 0)
        clanTrophyLabel.text = String(clanInfo.trophies)
        clanDonationsPerWeekLabel.text = String(clanInfo.donations ?? 0)
    }
    
    
}
