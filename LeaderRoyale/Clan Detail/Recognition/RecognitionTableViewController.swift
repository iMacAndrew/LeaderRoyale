//
//  RecognitionTableViewController.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit
import GoogleMobileAds

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
        view.backgroundColor = .dark
        tableView.register(UINib(nibName: "DonationsTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationsTableViewCell")
        tableView.register(UINib(nibName: "RecognitionTableViewCell", bundle: nil), forCellReuseIdentifier: "RecognitionTableViewCell")
        
        tableView.tableFooterView = UIView()

        // GADBannerView will show in top left of the view
        let bannerView = GADBannerView(adSize:kGADAdSizeBanner)
        adViewDidReceiveAd(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        self.view.addSubview(bannerView)
        bannerView.load(GADRequest())
        
    }


    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        print("Banner loaded successfully")
        tableView.tableHeaderView?.frame = bannerView.frame
        tableView.tableHeaderView = bannerView
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
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {



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
    
    func configure(clan: Clan) {
        if let member = clan.clanInfo.memberWithMostDonations, let donations = member.donations {
            let recognitionForMostDonations = Recognition(title: "Most Donations",
                                                          playerName: member.name ?? "",
                                                          stat: String(donations.withCommas()),
                                                          isGood: true)
            
            recognitions.append(recognitionForMostDonations)
            
        }
        
        if let member = clan.clanInfo.memberWithMostDonationsReceived, let donationsReceived = member.donationsReceived {
            let recognitionForMostDonationsReceived = Recognition(title: "Most Donations Received", playerName: member.name ?? "", stat: String(donationsReceived.withCommas()), isGood: nil)
            
            recognitions.append(recognitionForMostDonationsReceived)
        }
        
        if let member = clan.clanInfo.memberThatClimbedTheMostRanks {
            let recognitionForMembersThatClimbedTheMostRanks = Recognition(title: "Most Ranks Climbed", playerName: member.name ?? "", stat: String(member.ranksClimbed), isGood: true)
            
            recognitions.append(recognitionForMembersThatClimbedTheMostRanks)
        }

        if let member = clan.clanInfo.memberThatClimbedTheLeastRanks {
            let recognitionForMembersThatClimbedTheLeastRanks = Recognition(title: "Most Ranks Dropped", playerName: member.name ?? "", stat: String(member.ranksClimbed), isGood: false)

            recognitions.append(recognitionForMembersThatClimbedTheLeastRanks)
        }
        
        if let member = clan.clanInfo.memberWithHighestDonationRatio,
            let donations = member.donations,
            let donationsReceived = member.donationsReceived {
            let recognitionForHighestDonationRatio = Recognition(title: "Highest Donation Ratio", playerName: member.name ?? "", stat: "Gave:\(donations) Took:\(donationsReceived)", isGood: true)
        
            recognitions.append(recognitionForHighestDonationRatio)
            
        }

        if let member = clan.clanInfo.memberWithLowestDonationRatio,
            let donations = member.donations,
            let donationsReceived = member.donationsReceived {
            let recognitionForLowestDonationRatio = Recognition(title: "Lowest Donation Ratio",
                                                                 playerName: member.name ?? "",
                                                                 stat: "Gave:\(donations) Took:\(donationsReceived)",
                                                                 isGood: false)

            recognitions.append(recognitionForLowestDonationRatio)

        }

        if let player = clan.playerWithMostWarDayWins,
            let playerTag = player.tag {
            let recognitionForPlayerWithMostWarDayWins = Recognition(title: "Most War Day Wins",
                                                                     playerName: player.name ?? "",
                                                                     stat: String(clan.countWarWins(playerTag: playerTag)) + "/10",
                                                                     isGood: true)

            recognitions.append(recognitionForPlayerWithMostWarDayWins)
        }

        if let player = clan.playerWithMostWarDayLosses,
            let playerTag = player.tag {
            let recognitionForPlayerWithMostWarDayLosses = Recognition(title: "Most War Day Losses",
                                                                     playerName: player.name ?? "",
                                                                     stat: String(clan.countBattlesLost(playerTag: playerTag)) + "/10",
                                                                     isGood: false)

            recognitions.append(recognitionForPlayerWithMostWarDayLosses)
        }

        if let player = clan.playerWithMostCardsEarned,
            let playerTag = player.tag {
            let recognitionForPlayerWithMostCardEarned = Recognition(title: "Most Clan Cards Earned",
                                                                       playerName: player.name ?? "",
                                                                       stat: String(clan.countCardsEarned(playerTag: playerTag)),
                                                                       isGood: true)

            recognitions.append(recognitionForPlayerWithMostCardEarned)
        }

    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Recognitions"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}
