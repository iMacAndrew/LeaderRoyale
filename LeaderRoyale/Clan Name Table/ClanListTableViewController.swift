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
    
    var clans = [ClanInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        cell.configure(with: clans[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedClanInfo = clans[indexPath.row]
        
        performSegue(withIdentifier: "statSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let clanStats = segue.destination as? ClanDetailViewController else {
            return
        }
        
        if let clanInfo = selectedClanInfo {
            clanStats.clanInfo = clanInfo
        }
        
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Clans"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}
