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

    private var viewControllers = [ClanMemberTableViewController.make(), RecognitionTableViewController.make(), StatsTableViewController.make() ,ClanWarStatsTableViewController.make()]
    
    var titles = ["Members", "Recognitions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.contentMode = .intrinsic
        bar.buttons.customize { (button) in
            button.tintColor = .red
            button.selectedTintColor = .red
        }
        bar.indicator.cornerStyle = .rounded
        bar.indicator.tintColor = .red
        
//        bar.transitionStyle = .snap // Customize
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
    
    func configure(with clanInfo: ClanInfo?) {
        for viewController in viewControllers {
            if let clanMemberTableViewController = viewController as? ClanMemberTableViewController {
                clanMemberTableViewController.configure(clanInfo: clanInfo)
            }
            if let recognitionTableViewController = viewController as? RecognitionTableViewController {
                recognitionTableViewController.configure(clanInfo: clanInfo)
            }
            if let statsTableViewController = viewController as? StatsTableViewController {
                statsTableViewController.configure(clanInfo: clanInfo)
            }
            if let clanWarStatsTableViewController = viewController as? ClanWarStatsTableViewController {
                clanWarStatsTableViewController.configure(clanInfo: clanInfo)
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
            return TMBarItem(title: "Clan War Stats")
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
