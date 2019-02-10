//
//  PlayerProfileTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 2/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class PlayerProfileTableViewController: UITableViewController {
    
    var memberInfo: ClanInfo.Member?
    var playerInfo: PlayerInfo?
    private var sections = [Sections]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        view.backgroundColor = .dark
        tableView.register(UINib(nibName: "PlayerProfileStatsTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerProfileStatsTableViewCell")
        
        tableView.register(UINib(nibName: "PlayerDeckTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerDeckTableViewCell")
        
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 180.0
//
//    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {
            return createPlayerProfileStatsCell(indexPath: indexPath)
        } else {
            return createPlayerDeckCell(indexPath: indexPath)
        }
    }
    
    private func createPlayerProfileStatsCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerProfileStatsTableViewCell", for: indexPath) as! PlayerProfileStatsTableViewCell
        
        if let playerInfo = playerInfo {
            cell.configure(section: sections[indexPath.row], playerInfo: playerInfo)
        }
        
        
        return cell
    }
    
    private func createPlayerDeckCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerDeckTableViewCell", for: indexPath) as! PlayerDeckTableViewCell
        
        cell.configure(section: sections[indexPath.row], playerInfo: playerInfo)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func configure() {
            let statSection = Sections(title: "Stats")
            
            sections.append(statSection)
        
            let deckSection = Sections(title: "Deck")
        
            sections.append(deckSection)
    }

    private func setNavigationTitle() {
        navigationItem.title = "Profile"
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "supercell-magic", size: 20)!]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }

}
