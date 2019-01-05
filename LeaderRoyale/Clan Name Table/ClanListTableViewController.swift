//
//  ClanListTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ClanListTableViewController: UITableViewController {
    var clanInfo: ClanInfo?
    
    var clans = [ClanInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        cell.configure(with: clans[indexPath.row])
        
        return cell
    }
    
}
