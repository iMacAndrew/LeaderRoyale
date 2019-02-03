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
    
    static func make() -> StatsTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StatsTableViewController") as! StatsTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        view.backgroundColor = .dark
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func configure(clan: Clan) {
        let memberPercentage = clan.clanInfo.memberPercentages
        let memberCount = clan.clanInfo.countMembers
        let totalMemberPercentage = Stat(title: "Percentage of Members", stat: String(memberPercentage) + "%. " + String(memberCount) + " members")
        
        stats.append(totalMemberPercentage)
        
        let elderPercentage = clan.clanInfo.elderPercentages
        let elderCount = clan.clanInfo.countElders
        let totalElderPercentage = Stat(title: "Percentage of Elders", stat: String(elderPercentage) + "%. " + String(elderCount) + " elders")
        
        stats.append(totalElderPercentage)
        
        let coLeaderPercentage = clan.clanInfo.coLeaderPercentages
        let coLeaderCount = clan.clanInfo.countCoLeaders
        let totalCoLeaderPercentage = Stat(title: "Percentage of CoLeaders", stat: String(coLeaderPercentage) + "%. " + String(coLeaderCount) + " Co-Leaders")
        
        stats.append(totalCoLeaderPercentage)
        
        let averageDonations = clan.clanInfo.averageDonation
        let averageDonationsStat = Stat(title: "Average Donations for the week", stat: String(Int(averageDonations)))
        
        stats.append(averageDonationsStat)
        
        let totalTrophies = clan.clanInfo.trophies
        let averageTrophies = totalTrophies / memberCount
        let averageTrophyStat = Stat(title: "Average Trophies", stat: String(averageTrophies.withCommas()))
        
        stats.append(averageTrophyStat)

        let averageKingLevel = clan.clanInfo.averageKingLevel
        let averageKingLevelStat = Stat(title: "Average King Level", stat: String(averageKingLevel))
        
        stats.append(averageKingLevelStat)
        
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Stats"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}
