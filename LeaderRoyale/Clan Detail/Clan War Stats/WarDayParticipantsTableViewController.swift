//
//  WarDayParticipantsTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/12/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class WarDayParticipantsTableViewController: UITableViewController {

    private var warLog: Warlog!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        view.backgroundColor = .dark
        tableView.register(UINib(nibName: "ParticipantInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "ParticipantInfoTableViewCell")
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warLog.participants.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantInfoTableViewCell", for: indexPath) as! ParticipantInfoTableViewCell
        let participants = warLog.participants
        let participantInfo = participants[indexPath.row]
        cell.configure(with: participantInfo)

        return cell
    }

    func configure(warLog: Warlog) {
        self.warLog = warLog
    }

    func setNavigationTitle() {
        navigationItem.title = "Participants"

        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "supercell-magic", size: 15)!]
    }
}
