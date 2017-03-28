//
//  SwiftyNotificationsDrawings.swift
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

class SwiftyNotificationsDrawings {

    static func drawCheckmark(color: UIColor) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 8.0, y: 37.0))
        bezierPath.addLine(to: CGPoint(x: 27.0, y: 56.0))
        bezierPath.move(to: CGPoint(x: 27.0, y: 56.0))
        bezierPath.addLine(to: CGPoint(x: 75.0, y: 8.0))
        bezierPath.lineCapStyle = .round
        color.setStroke()
        bezierPath.lineWidth = 14
        bezierPath.stroke()
    }

    static func checkMarkImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 85, height: 63), false, 0)
        drawCheckmark(color: color)
        let checkmark = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return checkmark!
    }

}
