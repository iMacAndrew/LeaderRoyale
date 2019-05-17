//
//  RecognitionTableViewController.swift
//  LeaderRoyale
//
//  Created by Mariah Mays on 1/13/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit
import EasyTipView

class RecognitionTableViewController: UITableViewController {

    private var recognitions = [Recognition]()
    private var toolTip: EasyTipView?
    
    static func make() -> RecognitionTableViewController {
        return UIStoryboard(name: "Clans", bundle: nil).instantiateViewController(withIdentifier: "RecognitionTableViewController") as! RecognitionTableViewController
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
    }

    @IBAction func exportButtonPressed(_ sender: Any) {
        var items = [Any]()
        if let icon = UIImage(named: "icon") {
            items.append(icon)
        }
        items = items + recognitions.map { $0.description(withPowered: false) }
        items.append("Powered by Leader Royale")
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuItem = UIMenuItem(title: "Copy & Open Clash Royale", action: #selector(RecognitionTableViewCell.copyAndOpenClashRoyale(_:)))
        UIMenuController.shared.menuItems = [menuItem]
        UIMenuController.shared.update()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIMenuController.shared.menuItems = nil
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

    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }

    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        toolTip?.dismiss()
        return action == #selector(RecognitionTableViewCell.copyAndOpenClashRoyale(_:)) || action == #selector(copy(_:))
    }

    override func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        switch action {
        case #selector(copy(_:)):
            UIPasteboard.general.string = "I copied this to your pasteboard ;)"            
        default:
            assertionFailure("Unexpected action")
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            showTip(on: cell)
        }
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

    private func showTip(on cell: UITableViewCell) {
        let userDefaultsKey = "hasShownRecognizeToolTip"
        let hasShownToolTip = UserDefaults.standard.bool(forKey: userDefaultsKey)
        guard !hasShownToolTip else {
            return
        }
        UserDefaults.standard.set(true, forKey: userDefaultsKey)

        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "supercell-magic", size: 13)!
        preferences.drawing.foregroundColor = .white
        preferences.drawing.backgroundColor = .darkRed
        preferences.drawing.arrowPosition = .bottom

        toolTip = EasyTipView(text: "Press and hold to share with your clan.", preferences: preferences)
        toolTip?.show(animated: true, forView: cell, withinSuperview: tableView)
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
                                                                     stat: String(clan.countWarWins(playerTag: playerTag)) + " In 10 Wars",
                                                                     isGood: true)

            recognitions.append(recognitionForPlayerWithMostWarDayWins)
        }

        if let player = clan.playerWithMostWarDayLosses,
            let playerTag = player.tag {
            let recognitionForPlayerWithMostWarDayLosses = Recognition(title: "Most War Day Losses",
                                                                     playerName: player.name ?? "",
                                                                     stat: String(clan.countBattlesLost(playerTag: playerTag)) + " In 10 Wars",
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
