//
//  KeyboardView.swift
//  ClanKeyboard
//
//  Created by Mariah Mays on 5/16/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit


protocol KeyboardViewDelegate: AnyObject {
    func insert(text: String)
}

class KeyboardView: UIView {

    weak var delegate: KeyboardViewDelegate?

    @IBAction func testButtonPressed(_ sender: Any) {
        let clan = CoreDataManager.shared.clans.first!
        delegate?.insert(text: clan.clanInfo.tag!)
    }

}
