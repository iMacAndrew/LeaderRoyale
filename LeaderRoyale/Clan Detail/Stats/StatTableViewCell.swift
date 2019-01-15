//
//  StatTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/15/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class StatTableViewCell: UITableViewCell {
    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    func configure(stat: Stat) {
        statNameLabel.text = stat.title
        statLabel.text = stat.stat
    }
    
}
