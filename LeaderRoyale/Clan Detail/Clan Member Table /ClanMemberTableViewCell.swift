//
//  ClanMemberTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 12/2/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit

class ClanMemberTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var donatedCountLabel: UILabel!
    @IBOutlet weak var trophiesLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var donatedTitleLabel: UILabel!
    @IBOutlet weak var trophyContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trophyContainerView.layer.cornerRadius = 5
    }
    
    func configure(with memberInfo: ClanInfo.Member?) {
        guard let memberInfo = memberInfo else {
            return
        }
        
        if let rank = memberInfo.rank {
            rankLabel.text = String(rank)
        } else {
            rankLabel.text = ""
        }
        
        nameLabel.text = memberInfo.name
        
        if let donations = memberInfo.donations {
            donatedCountLabel.text = String(donations)
        } else {
            donatedCountLabel.text = ""
        }
        
        if let trophies = memberInfo.trophies {
            trophiesLabel.text = String(trophies)
        } else {
            trophiesLabel.text = ""
        }
        
        roleLabel.text = memberInfo.role
        
        let isLeader = memberInfo.role?.lowercased() == "leader"
        decorateLeaderCell(isLeader: isLeader)
    }
    
    private func decorateLeaderCell(isLeader: Bool) {
        if isLeader {
            rankLabel.textColor = .white
            nameLabel.textColor = .white
            donatedCountLabel.textColor = .white
            trophiesLabel.textColor = .white
            roleLabel.textColor = .white
            donatedTitleLabel.textColor = .white
            backgroundColor = .black
        } else {
            rankLabel.textColor = .black
            nameLabel.textColor = .black
            donatedCountLabel.textColor = .black
            trophiesLabel.textColor = .black
            donatedTitleLabel.textColor = .black
            roleLabel.textColor = .black
            backgroundColor = .white
        }
    }
}
