//
//  ClanDetailViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/5/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ClanDetailViewController: UITableViewController {
    
    var clanInfo: ClanInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        registerCells()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanOverviewTableViewCell", for: indexPath) as! ClanOverviewTableViewCell
        
        if let clanInfo = clanInfo {
            cell.configure(with: clanInfo)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270.0
    }
    
    private func setNavigationTitle() {
        navigationItem.title = clanInfo?.name
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "ClanOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ClanOverviewTableViewCell")
    }
    
}
