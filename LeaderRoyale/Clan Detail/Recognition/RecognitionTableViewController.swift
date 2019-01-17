//
//  RecognitionTableViewController.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class RecognitionTableViewController: UITableViewController {

    private var recognitions = [Recognition]()
    
    static func make() -> RecognitionTableViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecognitionTableViewController") as! RecognitionTableViewController
    }
    
    var memberInfo: ClanInfo.Member?
    var clanInfo: ClanInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        tableView.register(UINib(nibName: "DonationsTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationsTableViewCell")
        tableView.register(UINib(nibName: "RecognitionTableViewCell", bundle: nil), forCellReuseIdentifier: "RecognitionTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recognitions.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return createDonationCell(indexPath: indexPath)
        } else {
            return createRecognitionCell(indexPath: indexPath)
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            goToDonationList(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }

    private func createRecognitionCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecognitionTableViewCell", for: indexPath) as! RecognitionTableViewCell
        
        cell.configure(recognition: recognitions[indexPath.row - 1])
        
        return cell
    }
    
    private func createDonationCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationsTableViewCell", for: indexPath) as! DonationsTableViewCell
        
        cell.configure()
        
        return cell
    }
    
    func configure(clanInfo: ClanInfo?) {
        if let member = clanInfo?.memberWithMostDonations {
            let recognitionForMostDonations = Recognition(title: "Most Donations", subTitle: "This week", playerName: member.name ?? "", stat: String(member.donations ?? 0))
            
            recognitions.append(recognitionForMostDonations)
            
        }
        
        if let member = clanInfo?.memberWithMostDonationsReceived {
            let recognitionForMostDonationsReceived = Recognition(title: "Most Donations Received", subTitle: "This week", playerName: member.name ?? "", stat: String(member.donationsReceived ?? 0))
            
            recognitions.append(recognitionForMostDonationsReceived)
        }
        
        if let member = clanInfo?.memberThatClimbedTheMostRanks {
            let recognitionForMembersThatClimbedTheMostRanks = Recognition(title: "Most Ranks Climbed", subTitle: "This week", playerName: member.name ?? "", stat: String(member.ranksClimbed))
            
            recognitions.append(recognitionForMembersThatClimbedTheMostRanks)
        }
        
        if let member = clanInfo?.memberWithHighestDonationRatio {
            let recognitionForHighestDonationRatio = Recognition(title: "Highest Donation Ratio", subTitle: "This week", playerName: member.name ?? "", stat: String(member.donationRatio) + "%")
        
            recognitions.append(recognitionForHighestDonationRatio)
            
        }
        
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Recognitions"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    private func goToDonationList(indexPath: IndexPath) {
        performSegue(withIdentifier: "donationListSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let donationListTableViewController = segue.destination as? DonationListTableViewController {
            donationListTableViewController.clanInfo = clanInfo
            donationListTableViewController.memberInfo = memberInfo
        }
        
    }
}
