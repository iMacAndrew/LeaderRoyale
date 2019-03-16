//
//  InactiveWarMembersTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class InactiveWarMembersTableViewController: UITableViewController {

    var clan: Clan!
    private var members = [ClanInfo.Member]()
//    private var playerInfos = [PlayerInfo?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        view.backgroundColor = .dark
        tableView.register(UINib(nibName: "WarMemberDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "WarMemberDetailTableViewCell")
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WarMemberDetailTableViewCell", for: indexPath) as! WarMemberDetailTableViewCell

        if members.count >= indexPath.row {
            let memberInfo = members[indexPath.row]

            cell.configure(with: memberInfo, clan: clan)

        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }

    func configure(clan: Clan) {
        self.clan = clan
        members = clan.clanInfo.members ?? []
    }

    private func setNavigationTitle() {
        navigationItem.title = "Member Activity"

        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "supercell-magic", size: 15)!]

    }
}
