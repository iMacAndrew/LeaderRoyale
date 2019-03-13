//
//  InactiveWarMembersTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class InactiveWarMembersTableViewCell: UITableViewCell {

    @IBOutlet weak var inActiveWarMembersTitleLabel: UILabel!

    func configure() {
        inActiveWarMembersTitleLabel.text = "Member Activity"
        decorateCell()
    }

    func decorateCell() {
        backgroundColor = .dark
        inActiveWarMembersTitleLabel.textColor = .white
    }
    
}
