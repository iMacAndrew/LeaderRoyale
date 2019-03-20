//
//  ClanSearchViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/21/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import UIKit
import GoogleMobileAds
import MBProgressHUD

class ClanSearchViewController: UIViewController, UITextFieldDelegate {
    private var clan: Clan?
    private var shouldDisplayError = false


    @IBOutlet weak var clanSearchTextField: UITextField!
    
    @IBAction func openClashButton(_ sender: Any) {
        openClashRoyale()
    }
    
    @IBAction func clanSearchButtonPressed(_ sender: UIButton) {
        downloadClan()
    }

    @IBAction func searchKeyTriggered(_ sender: UITextField) {
        downloadClan()
    }
    
    private func downloadClan() {
        guard
            let clanId = clanSearchTextField.text,
            !clanId.isEmpty
        else {
            return
        }

        if navigationController != nil {
            AdManager.shared.present(on: self)
        }

        let clanDownloader = ClanDownloader(clanTag: clanId)
        let mbHud = MBProgressHUD.showAdded(to: view, animated: true)
        mbHud.label.text = "Downloading Clan"
        clanDownloader.download() { [weak self] clan in
            if let clan = clan {
                self?.clan = clan
                self?.goToClanListTable()
                DispatchQueue.main.async {
                    mbHud.hide(animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    mbHud.hide(animated: true)
                    self?.displayAlert()
                }
            }
        }
    }

    private func goToClanListTable() {
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
        
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        view.addGestureRecognizer(tapGesture)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shouldDisplayError {
            displayAlert()
        }
    }

    @objc func textFieldDidChange(textField: UITextField) {
        textField.text = textField.text?.uppercased()
    }
    
    func openClashRoyale() {
        let clashRoyale = "https://link.clashroyale.com/clan"
        let clashUrl = URL(string: clashRoyale)!
        if UIApplication.shared.canOpenURL(clashUrl) {
            UIApplication.shared.open(clashUrl, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clanSearchTextField.becomeFirstResponder()
    }
    
    func displayAlert() {
        shouldDisplayError = true
        let alert = UIAlertController(title: "Clan Not Found", message: "The clan tag you entered is incorrect. You can find your tag inside the clan info tab in the Clash Royale app.", preferredStyle: .alert)
        
        let openAction = UIAlertAction(title: "Open Clash Royale", style: .default) { _ in
            self.openClashRoyale()
            self.shouldDisplayError = false
        }
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {_ in self.shouldDisplayError = false }))
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

        if let clan = clan {
            clanTable?.addNew(clan: clan)
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
