//
//  DonationsTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/16/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class DonationsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure() {
        titleLabel.text = "Donations"
        decorateCell()
    }
    
    private func decorateCell() {
        backgroundColor = .dark
        titleLabel.textColor = UIColor.white
    }
    
}
