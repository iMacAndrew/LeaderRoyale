//
//  ClanTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/21/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit

class ClanTableViewController: UITableViewController {
    var memberInfo: ClanInfo.Member?
    var clanInfo: ClanInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = clanInfo?.name
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        tableView.register(UINib(nibName: "ClanMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "ClanMemberTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clanInfo?.members?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanMemberTableViewCell", for: indexPath) as! ClanMemberTableViewCell
        
        let memberCount = clanInfo?.members?.count ?? 0
        
        if memberCount >= indexPath.row {
            let memberInfo = clanInfo?.members?[indexPath.row]
            cell.configure(with: memberInfo)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let memberCount = clanInfo?.members?.count ?? 0
        
        if memberCount >= indexPath.row {
            memberInfo = clanInfo?.members?[indexPath.row]
        }
        
        performSegue(withIdentifier: "segueMemberVC2", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playerProfile = segue.destination as? PlayerProfileViewController else {
            return
        }

        if let memberInfo = memberInfo {
            playerProfile.memberInfo = memberInfo
        }
    }
}
