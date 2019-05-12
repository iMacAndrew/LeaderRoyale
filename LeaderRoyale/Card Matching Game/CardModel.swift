//
//  CardModel.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 5/7/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation

class CardModel {

    func getCards() -> [Card] {

        var generatedNumbersArray = [Int]()

        var generatedCardsArray = [Card]()

        while generatedNumbersArray.count < 9 {
            let randomNumber = arc4random_uniform(14) + 1

            if generatedNumbersArray.contains(Int(randomNumber)) == false {

                print(randomNumber)

                generatedNumbersArray.append(Int(randomNumber))

                let cardOne = Card(imageName: "card\(randomNumber)")

                generatedCardsArray.append(cardOne)

                let cardTwo = Card(imageName: "card\(randomNumber)")

                generatedCardsArray.append(cardTwo)
            }

        }

        return generatedCardsArray
    }
    
}
