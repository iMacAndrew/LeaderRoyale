//
//  CardModelTests.swift
//  LeaderRoyaleTests
//
//  Created by Andy Humphries on 5/8/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import XCTest
@testable import LeaderRoyale

class CardModelTests: XCTestCase {

    func testGetCardsContainsPairs() {
        let model = CardModel()
        let cards = model.getCards()

        for index in stride(from: 0, to: cards.count, by: 2) {
            let card1 = cards[index]
            let card2 = cards[index + 1]

            XCTAssertEqual(card1.imageName, card2.imageName)
        }
    }
    
}
