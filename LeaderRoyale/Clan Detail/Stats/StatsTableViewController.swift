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
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stats.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatTableViewCell", for: indexPath) as! StatTableViewCell

        cell.configure(stat: stats[indexPath.row])

        return cell
    }
    
    func configure(clanInfo: ClanInfo?) {
        
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Stats"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}
