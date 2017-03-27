//
//  RoundedView.swift
//  SwiftyNotifications
//
//  Created by Abdullah Selek on 27/03/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import UIKit

extension UIView {

    func makeRound() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        var frame = self.frame
        let width = frame.width
        let height = frame.height
        var corner = width
        if height > width { // Portrait Orientation
            frame.size.height = width
        } else if width > height { // Landscape Orientation
            frame.size.width = height
            corner = height
        }
        self.frame = frame
        self.layer.cornerRadius = corner / 2
        self.layoutIfNeeded()
    }

    func makeRoundWithBorderWidth(borderWidth: CGFloat, borderColor: UIColor) {
        makeRound()
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }

}
