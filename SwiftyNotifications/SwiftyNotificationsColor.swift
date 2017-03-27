//
//  SwiftyNotificationsColor.swift
//  SwiftyNotifications
//
//  Created by Abdullah Selek on 27/03/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import UIKit

extension UIColor {

    func hsbColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat) -> UIColor {
        return UIColor(hue: hue / 360.0,
                       saturation: saturation / 360.0,
                       brightness: brightness / 360.0,
                       alpha: 1.0)
    }

    func snGreenColor() -> UIColor {
        return hsbColor(hue: 145.0, saturation: 77.0, brightness: 80.0)
    }

    func snRedColor() -> UIColor {
        return hsbColor(hue: 6.0, saturation: 74.0, brightness: 91.0)
    }

    func snYellowColor() -> UIColor {
        return hsbColor(hue: 48.0, saturation: 83.0, brightness: 100.0)
    }

    func snBlueColor() -> UIColor {
        return hsbColor(hue: 224.0, saturation: 50.0, brightness: 63.0)
    }

    func snBlackColor() -> UIColor {
        return hsbColor(hue: 0.0, saturation: 0.0, brightness: 17.0)
    }

    func snWhiteColor() -> UIColor {
        return hsbColor(hue: 192.0, saturation: 2.0, brightness: 95.0)
    }

    func snOrangeColor() -> UIColor {
        return hsbColor(hue: 28.0, saturation: 85.0, brightness: 90.0)
    }

}
