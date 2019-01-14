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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        tableView.register(UINib(nibName: "RecognitionTableViewCell", bundle: nil), forCellReuseIdentifier: "RecognitionTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recognitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecognitionTableViewCell", for: indexPath) as! RecognitionTableViewCell

        cell.configure(recognition: recognitions[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
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
        
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Recognitions"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    

}
