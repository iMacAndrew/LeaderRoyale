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
    @IBOutlet weak var kinglevelLabel: UILabel!
    
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
            donatedCountLabel.text = String(donations.withCommas())
        } else {
            donatedCountLabel.text = ""
        }
        
        if let trophies = memberInfo.trophies {
            trophiesLabel.text = String(trophies.withCommas())
        } else {
            trophiesLabel.text = ""
        }
        
        kinglevelLabel.text = String(memberInfo.expLevel ?? 0)
        
        roleLabel.text = memberInfo.role
        
        let isLeader = memberInfo.role?.lowercased() == "leader"
        decorateLeaderCell(isLeader: isLeader)
    }
    
    private func decorateLeaderCell(isLeader: Bool) {
        let leaderTextColor = UIColor.white
        let nonLeaderTextColor = UIColor.white
        if isLeader {
            rankLabel.textColor = leaderTextColor
            nameLabel.textColor = leaderTextColor
            donatedCountLabel.textColor = leaderTextColor
            trophiesLabel.textColor = leaderTextColor
            roleLabel.textColor = .yellow
            donatedTitleLabel.textColor = leaderTextColor
            backgroundColor = .dark
        } else {
            rankLabel.textColor = nonLeaderTextColor
            nameLabel.textColor = nonLeaderTextColor
            donatedCountLabel.textColor = nonLeaderTextColor
            trophiesLabel.textColor = nonLeaderTextColor
            donatedTitleLabel.textColor = nonLeaderTextColor
            roleLabel.textColor = nonLeaderTextColor
            backgroundColor = .dark
        }
    }
}

