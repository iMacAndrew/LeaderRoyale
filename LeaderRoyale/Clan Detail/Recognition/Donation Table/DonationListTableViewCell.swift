//
//  DonationListTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/16/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class DonationListTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var donationAmountLabel: UILabel!
    
    func configure(donationInfo: DonationInfo) {
        playerNameLabel.text = donationInfo.playerName
        donationAmountLabel.text = donationInfo.stat
        
    }
    
}
