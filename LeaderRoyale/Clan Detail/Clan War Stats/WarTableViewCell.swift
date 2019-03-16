//
//  WarTableViewCell.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/12/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class WarTableViewCell: UITableViewCell {

    @IBOutlet weak var warTitleLabel: UILabel!
    @IBOutlet weak var warDayWinsLabel: UILabel!
    @IBOutlet weak var warDateLabel: UILabel!
    @IBOutlet weak var crownsLabel: UILabel!
    @IBOutlet weak var warTrophiesChangedLabel: UILabel!

    func configure(warLog: Warlog, warTitle: String, clanTag: String) {

        guard let standing = warLog.getStanding(for: clanTag) else {
            return
        }

        warTitleLabel.text = warTitle
        warDayWinsLabel.text = "Won \(standing.wins) / \(standing.battlesPlayed) Final Battles"
        crownsLabel.text = "\(standing.crowns) Crowns"
        warDateLabel.text = Date(timeIntervalSince1970: TimeInterval(warLog.createdDate)).getElapsedInterval() + " ago"

        if standing.warTrophiesChange > 0 {
            warTrophiesChangedLabel.text = "+\(standing.warTrophiesChange) "
        } else {
            warTrophiesChangedLabel.text = "\(standing.warTrophiesChange) "
        }


        var isWin: Bool

        if standing.warTrophiesChange >= 0 {
            isWin = true
            decorateCell(isWin: isWin)
        } else {
            isWin = false
            decorateCell(isWin: isWin)
        }

    }

    private func decorateCell(isWin: Bool) {

         backgroundColor = .dark
        warDayWinsLabel.textColor = .white
        warDateLabel.textColor = .white
        crownsLabel.textColor = .white


        if isWin {
            warTrophiesChangedLabel.textColor = .green
            warTitleLabel.textColor = .green
        } else {
            warTrophiesChangedLabel.textColor = .red
            warTitleLabel.textColor = .red
        }
    }
}

extension Date {
    func getElapsedInterval() -> String {

        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Bundle.main.preferredLocalizations[0]) //--> IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME IS GOING TO APPEAR IN SPANISH

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.calendar = calendar

        var dateString: String?

        let interval = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: self, to: Date())

        if let year = interval.year, year > 0 {
            formatter.allowedUnits = [.year] //2 years
        } else if let month = interval.month, month > 0 {
            formatter.allowedUnits = [.month] //1 month
        } else if let week = interval.weekOfYear, week > 0 {
            formatter.allowedUnits = [.weekOfMonth] //3 weeks
        } else if let day = interval.day, day > 0 {
            formatter.allowedUnits = [.day] // 6 days
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Bundle.main.preferredLocalizations[0]) //--> IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME IS GOING TO APPEAR IN SPANISH
            dateFormatter.dateStyle = .medium
            dateFormatter.doesRelativeDateFormatting = true

            dateString = dateFormatter.string(from: self) // IS GOING TO SHOW 'TODAY'
        }

        if dateString == nil {
            dateString = formatter.string(from: self, to: Date())
        }

        return dateString!
    }

}
