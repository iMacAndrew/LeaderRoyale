//
//  ClanListTableViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/3/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ClanListTableViewController: UITableViewController {
    private var selectedClan: Clan?
    var bannerView: GADBannerView!

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

        // GADBannerView will show in top left of the view
        let bannerView = GADBannerView(adSize:kGADAdSizeBanner)
        adViewDidReceiveAd(bannerView)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        self.view.addSubview(bannerView)
        bannerView.load(GADRequest())

    }

    @objc func requestData() {
        let group = DispatchGroup()
        for clan in clans {
            guard let clanTag = clan.clanInfo.tag else {
                continue
            }

            group.enter()
            let clanDownloader = ClanDownloader(clanTag: clanTag)
            clanDownloader.download { clan in
                group.leave()
                if let clan = clan {
                    CoreDataManager.shared.save(clan: clan)
                } else {
                    print("Failed to refresh \(clanTag)")
                }
            }
        }

        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.refresher.endRefreshing()
        }
    }

    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        print("Banner loaded successfully")
        tableView.tableHeaderView?.frame = bannerView.frame
        tableView.tableHeaderView = bannerView
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanNameTableViewCell", for: indexPath) as! ClanNameTableViewCell
        
        cell.configure(with: clans[indexPath.row].clanInfo)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
