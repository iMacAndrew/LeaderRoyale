//
//  ClanListTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit
import GoogleMobileAds
import EasyTipView

class ClanListTableViewController: UITableViewController {
    private var selectedClan: Clan?
    var bannerView: GADBannerView!
    private var isLoadingData = false
    private var toolTip: EasyTipView?

    private var clans: [Clan] {
        return CoreDataManager.shared.clans
    }

    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white

        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)

        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dark
        setNavigationTitle()
        tableView.register(UINib(nibName: "ClanNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ClanNameTableViewCell")
        tableView.refreshControl = refresher
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refresher.endRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isLoadingData {
            // for simplicity using harcoded height for refresh control
            tableView.setContentOffset(CGPoint(x: 0, y: -refresher.frame.height), animated: false)
            refresher.beginRefreshing()
        } else {
            refresher.endRefreshing()
        }
    }

    @objc func requestData() {
        AdManager.shared.present(on: self)

        isLoadingData = true
        let group = DispatchGroup()
        for clan in clans {
            guard let clanTag = clan.clanInfo.tag else {
                continue
            }

            group.enter()
            let clanDownloader = ClanDownloader(clanTag: clanTag)
            clanDownloader.download { clan in
                if var clan = clan {
                    clan.lastRefreshed = Date()
                    CoreDataManager.shared.save(clan: clan)
                } else {
                    print("Failed to refresh \(clanTag)")
                }

                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.isLoadingData = false
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanNameTableViewCell", for: indexPath) as! ClanNameTableViewCell
        
        cell.configure(with: clans[indexPath.row].clanInfo, lastRefreshDate: clans[indexPath.row].lastRefreshed)

        cell.selectionStyle = .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard clans.indices.contains(indexPath.row),
            let clanTag = clans[indexPath.row].clanInfo.tag else {
            return
        }

        if editingStyle == .delete {
            CoreDataManager.shared.delete(clanTag: clanTag)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        toolTip?.dismiss()
        selectedClan = clans[indexPath.row]

        performSegue(withIdentifier: "statSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let clanTabViewController = segue.destination as? ClanDetailTabViewController {
            
            if let clan = selectedClan {
                clanTabViewController.configure(with: clan)
            }
        
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            showTip(on: cell)
        }
    }

    private func showTip(on cell: UITableViewCell) {
        let userDefaultsKey = "hasShownClanToolTip"
        let hasShownToolTip = UserDefaults.standard.bool(forKey: userDefaultsKey)
        guard !hasShownToolTip else {
            return
        }
        UserDefaults.standard.set(true, forKey: userDefaultsKey)

        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "supercell-magic", size: 13)!
        preferences.drawing.foregroundColor = .white
        preferences.drawing.backgroundColor = .gray
        preferences.drawing.arrowPosition = .top

        toolTip = EasyTipView(text: "Tap a clan card to see details.", preferences: preferences)
        toolTip?.show(animated: true, forView: cell, withinSuperview: tableView)
    }
    
    @IBAction func unwindToClanListTableViewController(_ unwindSegue: UIStoryboardSegue) {

    }

    func addNew(clan: Clan) {
        CoreDataManager.shared.save(clan: clan)
        tableView.reloadData()
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "Clans"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "supercell-magic", size: 15)!]
    }

}
