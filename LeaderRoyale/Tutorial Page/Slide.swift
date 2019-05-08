//
//  Slide.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 4/8/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

protocol nextButtonProtocol: class {
    func didClickNext()
}

class Slide: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    weak var delegate: nextButtonProtocol?

    @IBAction func clickedNext(_ sender: Any) {
        self.delegate?.didClickNext()
    }

    override func awakeFromNib() {
        decorateXib()
    }

    private func decorateXib() {
        backgroundColor = .dark
        titleLabel.textColor = .white
        descLabel.textColor = .white
    }

}
