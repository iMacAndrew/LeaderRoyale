//
//  Card.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 5/7/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

class Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.imageName == rhs.imageName
    }

    var imageName: String
    var isFlipped = false
    var isMatched = false

    init(imageName: String) {
        self.imageName = imageName
    }
}
