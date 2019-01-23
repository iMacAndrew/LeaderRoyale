//
//  ClanMemberTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/21/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit

class ClanMemberTableViewController: UITableViewController {
    private var selectedMemberInfo: ClanInfo.Member?
    private var members = [ClanInfo.Member]()
    private var selectedPlayerInfo: PlayerInfo?
    
    
    static func make() -> ClanMemberTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClanMemberTableViewController") as! ClanMemberTableViewController
    }
    
    @IBAction func sortButtonPresssed(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        
        let sortByDonations = UIAlertAction(title: "Donations", style: .default) { (action) in
            self.sortByDonations()
        }
        
        let sortByTrophies = UIAlertAction(title: "Trophies", style: .default) { (action) in
            self.sortByTrophies()
        }
        
        let sortByKingLevel = UIAlertAction(title: "King Level", style: .default) { (action) in
            self.sortByKingLevel()
        }
        
        let sortByRole = UIAlertAction(title: "Role", style: .default) { (action) in
            self.sortByRole()
        }
        
        let cancelSort = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        actionSheet.addAction(sortByDonations)
        actionSheet.addAction(sortByTrophies)
        actionSheet.addAction(sortByKingLevel)
        actionSheet.addAction(cancelSort)
        actionSheet.addAction(sortByRole)
        
        present(actionSheet, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dark
        tableView.register(UINib(nibName: "ClanMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "ClanMemberTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanMemberTableViewCell", for: indexPath) as! ClanMemberTableViewCell
        
        if members.count >= indexPath.row {
            let memberInfo = members[indexPath.row]
            cell.configure(with: memberInfo)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if members.count >= indexPath.row {
            selectedMemberInfo = members[indexPath.row]
        }
        
        performSegue(withIdentifier: "segueMemberVC2", sender: self)
    }
    
    
    private func setNavigationTitle(title: String?) {
        navigationItem.title = title
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playerProfile = segue.destination as? PlayerProfileViewController else {
            return
        }

        if let selectedMemberInfo = selectedMemberInfo {
            playerProfile.memberInfo = selectedMemberInfo
        }
        if let selectedPlayerInfo = selectedPlayerInfo {
            playerProfile.playerInfo = selectedPlayerInfo
        }
    }
    
    func configure(clanInfo: ClanInfo?) {
        setNavigationTitle(title: clanInfo?.name)
        members = clanInfo?.members ?? []
    }
    
    func sortByDonations() {
        members.sort { (firstMember, secondMember) -> Bool in
            return firstMember.donations ?? 0 > secondMember.donations ?? 0
        }
        tableView.reloadData()
        
    }
    
    func sortByTrophies() {
        members.sort { (firstMember, secondMember) -> Bool in
            return firstMember.trophies ?? 0 > secondMember.trophies ?? 0
        }
        tableView.reloadData()
        
    }
    
    func sortByKingLevel() {
        members.sort { (firstMember, secondMember) -> Bool in
            return firstMember.expLevel ?? 0 > secondMember.expLevel ?? 0
        }
        tableView.reloadData()
        
    }
    
    func sortByRole() {
        members.sort { (firstMember, secondMember) -> Bool in
            return firstMember.roleAsInt > secondMember.roleAsInt
        }
        tableView.reloadData()
        
    }
}
