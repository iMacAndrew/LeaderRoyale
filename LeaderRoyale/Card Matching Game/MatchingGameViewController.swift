//
//  MatchingGameViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 5/7/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit
import GameKit

class MatchingGameViewController: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    var model = CardModel()
    var cardArray = [Card]()
    var firstCard: IndexPath?
    var timer: Timer?
    var miliseconds: Float = 45 * 1000 // 45 seconds
    let totalTime: Float = 45 * 1000 // 45 seconds


    // Game Center

    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID

    let LEADERBOARD_ID = "com.leaderroyale.memorymatch"


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

        authenticateLocalPlayer()

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

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

    func submitTimeToGC() {
        // Submit score to GC leaderboard
        let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)

        let elapsedTime = (totalTime - miliseconds) / 10.0
        bestScoreInt.value = Int64(elapsedTime)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }
    }

    @IBAction func pressedLeaderBoard(_ sender: Any) {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
    }

    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local

        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1. Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true

                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if error != nil { print(error)
                    } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })

            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                print(error)
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

        timer?.invalidate()
        submitTimeToGC()

        displayAlert(title, message)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {

            self.cardArray = self.model.getCards().shuffled()
            self.collectionView.reloadData()
            self.timer = nil
            self.miliseconds = self.totalTime
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
