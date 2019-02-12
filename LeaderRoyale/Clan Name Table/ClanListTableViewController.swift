//
//  ClanListTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ClanListTableViewController: UITableViewController {
    private var selectedClanInfo: ClanInfo?
    private var playerInfos: [PlayerInfo]?
    private var clans = [Clan]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dark
        setNavigationTitle()
        tableView.register(UINib(nibName: "ClanNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ClanNameTableViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanNameTableViewCell", for: indexPath) as! ClanNameTableViewCell
        
        cell.configure(with: clans[indexPath.row].clanInfo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedClanInfo = clans[indexPath.row].clanInfo
        playerInfos = clans[indexPath.row].players
        
    
        performSegue(withIdentifier: "statSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let clanTabViewController = segue.destination as? ClanDetailTabViewController {
            
            if let clanInfo = selectedClanInfo, let playerInfos = playerInfos {
                let clan = Clan(clanInfo: clanInfo, players: playerInfos)

                clanTabViewController.configure(with: clan)
            }
        
        }
    }
    
    func addNew(clan: Clan) {
        clans.append(clan)
        tableView.reloadData()
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Clans"
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "supercell-magic", size: 15)!]
    }
    
}
