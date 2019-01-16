//
//  StatsTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/14/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class StatsTableViewController: UITableViewController {

    private var stats = [Stat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        tableView.register(UINib(nibName: "StatTableViewCell", bundle: nil), forCellReuseIdentifier: "StatTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatTableViewCell", for: indexPath) as! StatTableViewCell

        cell.configure(stat: stats[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func configure(clanInfo: ClanInfo?) {
        if let memberPercentage = clanInfo?.memberPercentages, let memberCount = clanInfo?.countMembers {
            let totalMemberPercentage = Stat(title: "Percentage of Members", stat: String(memberPercentage) + "%. " + String(memberCount) + " members")
            
            stats.append(totalMemberPercentage)
            
        }
        
        if let elderPercentage = clanInfo?.elderPercentages,  let elderCount = clanInfo?.countElders {
            let totalElderPercentage = Stat(title: "Percentage of Elders", stat: String(elderPercentage) + "%. " + String(elderCount) + " elders")
            
            stats.append(totalElderPercentage)
            
        }
        
        if let coLeaderPercentage = clanInfo?.coLeaderPercentages, let coLeaderCount = clanInfo?.countCoLeaders {
            let totalCoLeaderPercentage = Stat(title: "Percentage of CoLeaders", stat: String(coLeaderPercentage) + "%. " + String(coLeaderCount) + " Co-Leaders")
            
            stats.append(totalCoLeaderPercentage)
            
        }
        
        if let averageDonations = clanInfo?.averageDonation {
            let averageDonationsStat = Stat(title: "Average Donations for the week", stat: String(Int(averageDonations)))
            
            stats.append(averageDonationsStat)
        }
        
        if let totalTrophies = clanInfo?.trophies, let memberCount = clanInfo?.members?.count {
            let averageTrophyStat = Stat(title: "Average Trophies", stat: String(totalTrophies / memberCount))
        
             stats.append(averageTrophyStat)
        }
        
        if let averageKingLevel = clanInfo?.averageKingLevel {
            let averageKingLevelStat = Stat(title: "Average King Level", stat: String(averageKingLevel))
            
            stats.append(averageKingLevelStat)
        }
       
    }
    
    
    
    private func setNavigationTitle() {
        navigationItem.title = "Stats"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}
