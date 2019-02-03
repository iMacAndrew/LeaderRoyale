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
    
    func configure(section: Sections) {
        sectionTitle.text = section.title  
    }
    
}
