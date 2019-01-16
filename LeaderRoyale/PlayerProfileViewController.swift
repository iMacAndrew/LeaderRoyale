//
//  PlayerProfileViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/23/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit

class PlayerProfileViewController: UIViewController {
    var memberInfo: ClanInfo.Member?
   
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerTagLabel: UILabel!
    @IBOutlet weak var playerExpLevelLabel: UILabel!
    @IBOutlet weak var playerTrophiesLabel: UILabel!    
    @IBOutlet weak var playerRoleLabel: UILabel!
    @IBOutlet weak var playerClanRankLabel: UILabel!
    @IBOutlet weak var playerDonationsLabel: UILabel!
    @IBOutlet weak var playerDonationsReceivedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerNameLabel.text = memberInfo?.name
        playerTagLabel.text = memberInfo?.tag
        
        if let playerExpLevel = memberInfo?.expLevel {
            playerExpLevelLabel.text = "\(playerExpLevel)"
        }
        
        if let playerTropies = memberInfo?.trophies {
            playerTrophiesLabel.text = "\(playerTropies)"
        }
        
        playerRoleLabel.text = memberInfo?.role
        
        if let playerClanRank = memberInfo?.rank {
            playerClanRankLabel.text = "\(playerClanRank)"
        }
        
        if let playerDonations = memberInfo?.donations {
            playerDonationsLabel.text = "\(playerDonations)"
        }
        
        if let playerDonationsReceived = memberInfo?.donationsReceived {
            playerDonationsReceivedLabel.text = "\(playerDonationsReceived)"
        }
        
    }
}
