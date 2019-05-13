//
//  CardCollectionViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 5/8/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!

    func flip() {

        UIView.transition(from: self.backImageView, to: self.frontImageView,
                          duration: 0.3, options: [.beginFromCurrentState, .transitionFlipFromLeft, .showHideTransitionViews, .allowUserInteraction],
                          completion: { _ in
                            self.frontImageView.isHidden = false
        })

    }

    func flipBack() {

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {

            UIView.transition(from: self.frontImageView, to: self.backImageView,
                              duration: 0.3, options: [.beginFromCurrentState, .transitionFlipFromRight, .showHideTransitionViews, .allowUserInteraction],
                              completion: nil)

        }

    }

    func remove() {

        self.backImageView.alpha = 0

        UIView.animate(withDuration: 0.3, delay: 0.5, options: [.beginFromCurrentState, .curveEaseOut, .allowUserInteraction], animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)



    }

}
