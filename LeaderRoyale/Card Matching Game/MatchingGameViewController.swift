//
//  MatchingGameViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 5/7/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class MatchingGameViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var model = CardModel()
    var cardArray = [Card]()
    var firstCard: IndexPath?
    var timer: Timer?
    var miliseconds: Float = 45 * 1000 // 45 seconds

    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        if miliseconds <= 0 {
            timer?.invalidate()
        }

        cardArray = model.getCards().shuffled()
        collectionView.backgroundColor = .clear
        timeRemainingLabel.textColor = .white
        view.backgroundColor = .dark
    }

    @objc func timerElapsed() {
        miliseconds -= 1
        // convert to seconds
        let seconds = String(format: "%.2f", miliseconds / 1000)

        DispatchQueue.main.async {
            self.timeRemainingLabel.text = "Time Remaining: \(seconds)"
        }

        if miliseconds <= 0 {
            timer?.invalidate()

            DispatchQueue.main.async {
                self.timeRemainingLabel.textColor = .red

                // check if any matches left to get
                self.checkGameEnded()
            }
        }

    }

}

// MARK: - UICollectionViewDataSource
extension MatchingGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        cell.backImageView.image = UIImage(named: "legendarycardbackground")
        cell.frontImageView.image = UIImage(named: cardArray[indexPath.item].imageName)
        let card = cardArray[indexPath.row]

        if  cell.frontImageView.isHidden != true {
            cell.frontImageView.isHidden = true
        }

        cell.backImageView.isHidden = false

        if card.isMatched == true {
            cell.backImageView.alpha = 0
            cell.frontImageView.alpha = 0
        } else {
            cell.backImageView.alpha = 1
            cell.frontImageView.alpha = 1
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if miliseconds <= 0 {
            return
        }

        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        if !card.isFlipped && card.isMatched == false {
            cell.flip()
            card.isFlipped = true

            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 0.001, target: self,
                                             selector: #selector(timerElapsed),
                                             userInfo: nil, repeats: true)
                DispatchQueue.global(qos: .userInitiated).async {
                    RunLoop.current.add(self.timer!, forMode: .common)
                }
            }

            if firstCard == nil {
                firstCard = indexPath
            } else {
                checkForMatches(indexPath)
            }

        } else {
            cell.flipBack()
            card.isFlipped = false
            firstCard = nil
        }
    }

    func checkForMatches(_ secondCard: IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstCard!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondCard) as? CardCollectionViewCell

        let cardOne = cardArray[firstCard!.row]
        let cardTwo = cardArray[secondCard.row]

        if cardOne == cardTwo && cardOne !== cardTwo {
            cardOne.isMatched = true
            cardTwo.isMatched = true

            cardOneCell?.remove()
            cardTwoCell?.remove()

            // check if there are any cards left unmatched
            checkGameEnded()

        } else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false

            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }

        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstCard!])
        }

        firstCard = nil
    }


    func checkGameEnded() {
        // Determine if there are any cards unmatched
        var isWon = true

        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        var title = ""
        var message = ""
        // if not, then user has won, stop the timer
        if isWon == true {
            if miliseconds > 0 {
                timer?.invalidate()
            }
            title = "Congratulations!"
            message = "You won!"
        }
        else {
            if miliseconds > 0 {
                return
            }

            title = "Game Over"
            message = " You Lost"
        }

        displayAlert(title, message)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {

            self.cardArray = self.model.getCards().shuffled()
            self.collectionView.reloadData()
            self.timer = nil
            self.miliseconds = 45 * 1000
            let seconds = String(format: "%.2f", self.miliseconds/1000)
            self.timeRemainingLabel.textColor = .white
            self.timeRemainingLabel.text = "Time Remaining: \(seconds)"

        }

    }

    func displayAlert(_ title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)

        alert.addAction(alertAction)

        present(alert, animated: true, completion: nil)
    }

}

// MARK: - UICollectionViewDelegate
extension MatchingGameViewController: UICollectionViewDelegate {

}
