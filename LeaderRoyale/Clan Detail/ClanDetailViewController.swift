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
    var cellNames = ["Members", "Recognition", "Stats", "Clan War"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        registerCells()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNames.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return createOverviewCell(indexPath: indexPath)
        }
        else {
            return createCell(indexPath: indexPath)
        }
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 270.0
        } else {
            return 90.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 1 {
            goToMembers(indexPath: indexPath)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let clanMembersTableViewController = segue.destination as? ClanMemberTableViewController {
            clanMembersTableViewController.clanInfo = clanInfo
        }
        
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
    
    private func createOverviewCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanOverviewTableViewCell", for: indexPath) as! ClanOverviewTableViewCell
        
        if let clanInfo = clanInfo {
            cell.configure(with: clanInfo)
        }
        return cell
    }
    
    private func createCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = cellNames[indexPath.row - 1]
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    private func goToMembers(indexPath: IndexPath) {
        
        performSegue(withIdentifier: "memberSegue", sender: self)
        
        //performSegue(withIdentifier: "memberSegue", sender: self)
    }
    
    
}
