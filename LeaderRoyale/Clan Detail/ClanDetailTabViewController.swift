//
//  ClanDetailTabViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 1/16/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Pageboy
import Tabman

class ClanDetailTabViewController: TabmanViewController {

    var clanInfo: ClanInfo?
    var playerInfos: [PlayerInfo]?
    
    private var viewControllers = [ClanMemberTableViewController.make(), RecognitionTableViewController.make(), StatsTableViewController.make() ,ClanWarStatsTableViewController.make()]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.contentMode = .intrinsic
        bar.buttons.customize { (button) in
            button.tintColor = .white
            button.selectedTintColor = .white
        }
        bar.indicator.cornerStyle = .rounded
        bar.indicator.tintColor = .darkRed
        bar.backgroundView.style = .flat(color: .darkNavBar)
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
        bar.delegate = self
        bar.layout.contentInset.left = 10.0
        bar.layout.contentInset.right = 10.0
        
        bar.layout.transitionStyle = .snap
        bar.scrollMode = .swipe
    }
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController,
                               didScrollToPageAt index: PageboyViewController.PageIndex,
                               direction: PageboyViewController.NavigationDirection,
                               animated: Bool) {
         navigationItem.rightBarButtonItem = viewControllers[index].navigationItem.rightBarButtonItem
    }
    
    
    
    func configure(with clan: Clan) {
        
        for viewController in viewControllers {
            if let clanMemberTableViewController = viewController as? ClanMemberTableViewController
            {
                clanMemberTableViewController.configure(clan: clan)
            }
            if let recognitionTableViewController = viewController as? RecognitionTableViewController {
                recognitionTableViewController.configure(clan: clan)
            }
            if let statsTableViewController = viewController as? StatsTableViewController {
                statsTableViewController.configure(clan: clan)
            }
            if let clanWarStatsTableViewController = viewController as? ClanWarStatsTableViewController {
                clanWarStatsTableViewController.configure(clan: clan)
            }
            
            
        }
    }
    
}

extension ClanDetailTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        switch viewControllers[index] {
        case is ClanMemberTableViewController:
            return TMBarItem(title: "Members")
        case is RecognitionTableViewController:
             return TMBarItem(title: "Recognitions")
        case is StatsTableViewController:
            return TMBarItem(title: "Stats")
        case is ClanWarStatsTableViewController:
            return TMBarItem(title: "Clan War")
        default:
            return TMBarItem(title: "Unknown")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
}

