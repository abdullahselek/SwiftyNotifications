//
//  SwiftyNotificationsColor.swift
//  SwiftyNotifications
//
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

internal extension UIColor {

    static func hsbColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat) -> UIColor {
        return UIColor(hue: hue / 360.0,
                       saturation: saturation / 100.0,
                       brightness: brightness / 100.0,
                       alpha: 1.0)
    }

    static func snGreenColor() -> UIColor {
        return hsbColor(hue: 145.0, saturation: 77.0, brightness: 80.0)
    }

    static func snRedColor() -> UIColor {
        return hsbColor(hue: 6.0, saturation: 74.0, brightness: 91.0)
    }

    static func snYellowColor() -> UIColor {
        return hsbColor(hue: 48.0, saturation: 83.0, brightness: 100.0)
    }

    static func snBlueColor() -> UIColor {
        return hsbColor(hue: 224.0, saturation: 50.0, brightness: 63.0)
    }

    static func snBlackColor() -> UIColor {
        return hsbColor(hue: 0.0, saturation: 0.0, brightness: 17.0)
    }

    static func snWhiteColor() -> UIColor {
        return hsbColor(hue: 192.0, saturation: 2.0, brightness: 95.0)
    }

    static func snOrangeColor() -> UIColor {
        return hsbColor(hue: 28.0, saturation: 85.0, brightness: 90.0)
    }

}
