//
//  ClanSearchViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/21/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit

class ClanSearchViewController: UIViewController, UITextFieldDelegate {

    let clashRoyaleApi = ClashRoyaleAPI()
    
    var clanInfo: ClanInfo?
    var playerInfos: [PlayerInfo]?
    
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
        guard let clanId = clanSearchTextField.text else {
            return
        }
        
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
        guard let playerIds = clanInfo?.returnPlayerTags else { return }
        
        clashRoyaleApi.getPlayerInfo(playerTags: playerIds) { playerInfos in
            if playerInfos != nil {
                self.playerInfos = playerInfos
                self.goToClanListTable()
            } else {
                DispatchQueue.main.async {
                    self.displayAlert()
                }
            }
        }
        
    }
    
    private func goToClanListTable() {
        DispatchQueue.main.async {
            if let navBar = self.navigationController {
                navBar.popViewController(animated: true)
                let clanTable = navBar.topViewController as? ClanListTableViewController
                
                if let clanInfo = self.clanInfo, let playerInfos = self.playerInfos {
                    let clan = Clan(clanInfo: clanInfo, players: playerInfos)
                    clanTable?.addNew(clan: clan)
                }
            } else {
                self.performSegue(withIdentifier: "clanIdentifier", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let navController = segue.destination as? UINavigationController,
            let clanTable = navController.topViewController as? ClanListTableViewController
        else {
            return
        }
    
        if let clanInfo = self.clanInfo, let playerInfos = self.playerInfos {
            let clan = Clan(clanInfo: clanInfo, players: playerInfos)
            clanTable.addNew(clan: clan)
        }
        
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
