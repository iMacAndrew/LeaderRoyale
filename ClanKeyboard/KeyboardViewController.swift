//
//  KeyboardViewController.swift
//  ClanKeyboard
//
//  Created by Mariah Mays on 5/16/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    let clan = CoreDataManager.shared.clans.first!
    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let keyboardView = nib.instantiate(withOwner: self, options: nil).first as! KeyboardView
        keyboardView.delegate = self
        
        view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        keyboardView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        keyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
}

extension KeyboardViewController: KeyboardViewDelegate {
    func insert(text: String) {
        textDocumentProxy.insertText(text)
    }
}
