//
//  ClanWarStatsTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/16/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class ClanWarStatsTableViewController: UITableViewController {

    private var clan: Clan!
    private var selectedWarLog: Warlog?
    
    static func make() -> ClanWarStatsTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClanWarStatsTableViewController") as! ClanWarStatsTableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        view.backgroundColor = .dark
        tableView.register(UINib(nibName: "WarTableViewCell", bundle: nil), forCellReuseIdentifier: "WarTableViewCell")
        tableView.register(UINib(nibName: "InactiveWarMembersTableViewCell", bundle: nil), forCellReuseIdentifier: "InactiveWarMembersTableViewCell")
        tableView.tableFooterView = UIView()
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clan.warLogs.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return createInactiveWarMemberCell(indexPath: indexPath)
        } else {
            return createWarCell(indexPath: indexPath)
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            performSegue(withIdentifier: "inactiveMemberSegue", sender: self)
        } else {
            selectedWarLog = clan.warLogs[indexPath.row]

            performSegue(withIdentifier: "warParticipantSegue", sender: self)
        }
        }



    private func createWarCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WarTableViewCell", for: indexPath) as! WarTableViewCell

        if let clanTag = clan.clanInfo.tag {
            cell.configure(warLog: clan.warLogs[indexPath.row], warTitle: "War \(indexPath.row)", clanTag: clanTag)
        }

        cell.accessoryType = .disclosureIndicator

        return cell
    }

    private func createInactiveWarMemberCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InactiveWarMembersTableViewCell", for: indexPath) as! InactiveWarMembersTableViewCell
        cell.configure()
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let inactiveWarMembersTableViewController = segue.destination as? InactiveWarMembersTableViewController,
            let clan = clan {
            inactiveWarMembersTableViewController.clan = clan
            inactiveWarMembersTableViewController.configure(clan: clan)
        }

        if let warDayParticipantsTableViewController = segue.destination as? WarDayParticipantsTableViewController,
        let selectedWarLog = selectedWarLog {
            warDayParticipantsTableViewController.configure(warLog: selectedWarLog)
        }

    }
    
    func configure(clan: Clan) {
        self.clan = clan
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Clan War Stats"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
}
