//
//  ButtonStyler.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 11/22/18.
//  Copyright © 2018 Marz Software. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StyledButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = UIColor.white.withAlphaComponent(0.3)
    }
}
