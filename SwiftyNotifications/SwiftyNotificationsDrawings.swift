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

internal class SwiftyNotificationsDrawings {

    internal static func drawCheckmark(color: UIColor) {
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

    internal static func checkMarkImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 85, height: 63), false, 0)
        drawCheckmark(color: color)
        let checkmark = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return checkmark!
    }

    internal static func drawCross(color: UIColor) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 10.0, y: 10.0))
        bezierPath.addLine(to: CGPoint(x: 53.0, y: 53.0))
        bezierPath.move(to: CGPoint(x: 10.0, y: 53.0))
        bezierPath.addLine(to: CGPoint(x: 53.0, y: 10.0))
        bezierPath.lineCapStyle = .round
        color.setStroke()
        bezierPath.lineWidth = 10
        bezierPath.stroke()
    }

    internal static func crossImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 63.0, height: 63.0), false, 0)
        drawCross(color: color)
        let cross = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return cross!
    }

    internal static func drawInfo(color: UIColor) {
        let info = UIBezierPath()
        info.move(to: CGPoint(x: 45.66, y: 15.96))
        info.addCurve(to: CGPoint(x: 45.66, y: 5.22),
                      controlPoint1: CGPoint(x: 48.78, y: 12.99),
                      controlPoint2: CGPoint(x: 48.78, y: 8.19))
        info.addCurve(to: CGPoint(x: 34.34, y: 5.22),
                      controlPoint1: CGPoint(x: 42.53, y: 2.26),
                      controlPoint2: CGPoint(x: 37.47, y: 2.26))
        info.addCurve(to: CGPoint(x: 34.34, y: 15.96),
                      controlPoint1: CGPoint(x: 32.22, y: 8.19),
                      controlPoint2: CGPoint(x: 31.22, y: 12.99))
        info.addCurve(to: CGPoint(x: 45.66, y: 15.96),
                      controlPoint1: CGPoint(x: 37.47, y: 18.92),
                      controlPoint2: CGPoint(x: 42.53, y: 18.92))
        info.close()
        info.move(to: CGPoint(x: 48.0, y: 69.41))
        info.addCurve(to: CGPoint(x: 40.0, y: 77.0),
                      controlPoint1: CGPoint(x: 48.0, y: 73.58),
                      controlPoint2: CGPoint(x: 44.4, y: 77.0))
        info.addLine(to: CGPoint(x: 40.0, y: 77.0))
        info.addCurve(to: CGPoint(x: 32.0, y: 69.41),
                      controlPoint1: CGPoint(x: 35.6, y: 77.0),
                      controlPoint2: CGPoint(x: 32.0, y: 73.58))
        info.addLine(to: CGPoint(x: 32.0, y: 35.26))
        info.addCurve(to: CGPoint(x: 40.0, y: 27.67),
                      controlPoint1: CGPoint(x: 32.0, y: 31.08),
                      controlPoint2: CGPoint(x: 35.6, y: 27.67))
        info.addLine(to: CGPoint(x: 40.0, y: 27.67))
        info.addCurve(to: CGPoint(x: 48.0, y: 35.26),
                      controlPoint1: CGPoint(x: 44.4, y: 27.67),
                      controlPoint2: CGPoint(x: 48.0, y: 31.08))
        info.addLine(to: CGPoint(x: 48.0, y: 69.41))
        info.close()
        color.setFill()
        info.fill()
    }

    internal static func infoImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 80.0, height: 80.0), false, 0)
        drawInfo(color: color)
        let info = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return info!
    }

    internal static func drawWarning(backgroundColor: UIColor, foregroundColor: UIColor) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 54.0, y: 10.0))
        bezierPath.addLine(to: CGPoint(x: 11.0, y: 81.0))
        bezierPath.addLine(to: CGPoint(x: 54.0, y: 81.0))
        bezierPath.addLine(to: CGPoint(x: 97.0, y: 81.0))
        bezierPath.addLine(to: CGPoint(x: 54.0, y: 10.0))
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        backgroundColor.setFill()
        bezierPath.fill()
        backgroundColor.setStroke()
        bezierPath.lineWidth = 14
        bezierPath.stroke()

        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 54.0, y: 48.0))
        bezier2Path.addLine(to: CGPoint(x: 54.0, y: 71.0))
        bezier2Path.lineCapStyle = .round
        bezier2Path.lineJoinStyle = .round
        foregroundColor.setFill()
        bezier2Path.fill()
        foregroundColor.setStroke()
        bezier2Path.lineWidth = 14
        bezier2Path.stroke()

        let oval = UIBezierPath(ovalIn: CGRect(x: 47.0, y: 19.0, width: 14.0, height: 14.0))
        foregroundColor.setFill()
        oval.fill()
    }

    internal static func warningImage(backgroundColor: UIColor, foregroundColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 108.0, height: 92.0), false, 0)
        drawWarning(backgroundColor: backgroundColor, foregroundColor: foregroundColor)
        let warning = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return warning!
    }

}

internal extension UIImage {

    func scaleImageToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        return image
    }

    func scaleImageToFitSize(size: CGSize) -> UIImage {
        let aspect = self.size.width / self.size.height
        if size.width / aspect <= size.height {
            return scaleImageToSize(size: CGSize(width: size.width, height: size.width / aspect))
        } else {
            return scaleImageToSize(size: CGSize(width: size.height * aspect, height: size.height))
        }
    }

}
