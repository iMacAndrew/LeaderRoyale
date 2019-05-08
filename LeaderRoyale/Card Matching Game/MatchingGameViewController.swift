//
//  MatchingGameViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 5/7/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class MatchingGameViewController: UIViewController {

    var model = CardModel()
    var cardArray = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        cardArray = model.getCards()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return true
    }

}
