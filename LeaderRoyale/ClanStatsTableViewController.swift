//
//  ClanStatsTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/5/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ClanStatsTableViewController: UITableViewController {
    
    var clanInfo: ClanInfo?
    var memberInfo: ClanInfo.Member?
    
    var rows = ["members"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = clanInfo?.name
        
        let attributes: [NSAttributedStringKey: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statsCellIdentifier", for: indexPath)
        
        return cell
    }
    
}
