//
//  DonationListTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/16/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class DonationListTableViewController: UITableViewController {

    var clanInfo: ClanInfo?
    var memberInfo: ClanInfo.Member?
    
    var donations = [DonationInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        tableView.register(UINib(nibName: "DonationListTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationListTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationListTableViewCell", for: indexPath) as! DonationListTableViewCell

        cell.configure(donationInfo: donations[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func configure(clanInfo: ClanInfo?) {
        
        if let member = clanInfo?.memberWithMostDonations {
            let donationForEachMember = DonationInfo(playerName: member.name ?? "", stat: "hi")
        
            donations.append(donationForEachMember)
        }
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Donations"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
}
