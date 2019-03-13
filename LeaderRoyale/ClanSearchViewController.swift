//
//  ClanSearchViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/21/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ClanSearchViewController: UIViewController, UITextFieldDelegate {

    let clashRoyaleApi = ClashRoyaleAPI()
    
    var clanInfo: ClanInfo?
    var playerInfos: [PlayerInfo]?
    var warLogs: [Warlog]?
    var isSearching = false
    
    @IBOutlet weak var clanSearchTextField: UITextField!
    
    @IBAction func openClashButton(_ sender: Any) {
        openClashRoyale()
    }
    
    @IBAction func clanSearchButtonPressed(_ sender: UIButton) {
        checkClan()
    }

    @IBAction func searchKeyTriggered(_ sender: UITextField) {
        checkClan()
    }
    
    private func checkClan() {

        guard !isSearching else {
            return
        }

        guard let clanId = clanSearchTextField.text else {
            return
        }

        isSearching = true
        
        clashRoyaleApi.getClanInfo(clanTag: clanId) { clanInfo in
            if clanInfo?.tag != nil {
                print("CLAN")
                DispatchQueue.main.async {
                    self.clanInfo = clanInfo
                    self.checkPlayers()
                }
            } else {
                DispatchQueue.main.async {
                    self.displayAlert()
                }
                print("not a clan")
            }
            
        }
    }
    
    private func checkPlayers() {
        guard let playerIds = clanInfo?.returnPlayerTags else {
            DispatchQueue.main.async {
                self.displayAlert()
            }
            return
        }
        
        clashRoyaleApi.getPlayerInfo(playerTags: playerIds) { playerInfos in
            if playerInfos != nil {
                self.playerInfos = playerInfos
                self.getWarLog()
            } else {
                DispatchQueue.main.async {
                    self.displayAlert()
                }
            }
        }
        
    }

    private func getWarLog() {
        guard let clanId = clanInfo?.tag else {
            DispatchQueue.main.async {
                self.displayAlert()
            }
            return
        }

        clashRoyaleApi.getWarLogs(clanTag: clanId) { (warLogs) in
            if warLogs != nil {
                self.warLogs = warLogs
                self.goToClanListTable()
            } else {
                DispatchQueue.main.async {
                    self.displayAlert()
                }
            }
        }


    }
    
    private func goToClanListTable() {
        isSearching = false
        DispatchQueue.main.async {
            if self.navigationController != nil {
                self.performSegue(withIdentifier: "unwindToClanListTableViewController", sender: self)
            } else {
                self.performSegue(withIdentifier: "clanIdentifier", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .dark
        
        clanSearchTextField.autocapitalizationType = UITextAutocapitalizationType.allCharacters

        clanSearchTextField.addTarget(self, action: #selector(ClanSearchViewController.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        clanSearchTextField.text = "#P8CVYUR0"

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        view.addGestureRecognizer(tapGesture)

    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        textField.text = textField.text?.uppercased()
    }
    
    func openClashRoyale() {
        let clashRoyale = "https://link.clashroyale.com"
        let clashUrl = URL(string: clashRoyale)!
        if UIApplication.shared.canOpenURL(clashUrl)
        {
            UIApplication.shared.open(clashUrl, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clanSearchTextField.becomeFirstResponder()
    }
    
    func displayAlert() {
        isSearching = false
        let alert = UIAlertController(title: "Clan Not Found", message: "The clan tag you entered is incorrect. You can find your tag inside the clan info tab in the Clash Royale app.", preferredStyle: .alert)
        
        let openAction = UIAlertAction(title: "Open Clash Royale", style: .default) { _ in
            self.openClashRoyale()
        }
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        alert.addAction(openAction)
        
        self.present(alert, animated: true)
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        clanSearchTextField.resignFirstResponder()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let clanTable: ClanListTableViewController?

        if let navController = segue.destination as? UINavigationController {
            clanTable = navController.topViewController as? ClanListTableViewController
        } else {
            clanTable = segue.destination as? ClanListTableViewController
        }

        if let clanInfo = self.clanInfo, let playerInfos = self.playerInfos, let warLogs = self.warLogs {
            let clan = Clan(clanInfo: clanInfo, players: playerInfos, warLogs: warLogs)
            clanTable?.addNew(clan: clan)
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
