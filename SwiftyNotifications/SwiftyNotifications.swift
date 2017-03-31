//
//  SwiftyNotifications.swift
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

public enum SwiftyNotificationsStyle {
    case normal
    case error
    case success
    case info
    case warning
    case custom
    case blurDark
    case blurLight
}

@objc public protocol SwiftyNotificationsDelegate: class {

    @objc optional func willShowNotification(notification: SwiftyNotifications)
    @objc optional func didShowNotification(notification: SwiftyNotifications)
    @objc optional func willDismissNotification(notification: SwiftyNotifications)
    @objc optional func didDismissNotification(notification: SwiftyNotifications)

}

typealias SwiftyNotificationsTouchHandler = () -> Void

public class SwiftyNotifications: UIView {

    @IBOutlet weak var leftAccessoryView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtitleLabelBottomConstraint: NSLayoutConstraint!

    public var style: SwiftyNotificationsStyle!
    public var fromTop: Bool!
    public var delegate: SwiftyNotificationsDelegate!

    class func instanceFromNib() -> UIView {
        let bundleIdentifier = "com.abdullahselek.SwiftyNotifications"
        let bundle = Bundle(identifier: bundleIdentifier)
        return bundle?.loadNibNamed("SwiftyNotifications", owner: nil, options: nil)?.first as! UIView
    }

    internal func setTitle(title: String, subtitle: String?) {
        if !title.isEmpty {
            titleLabel.text = title
        }
        guard let subtitleText = subtitle else {
            subtitleLabel.isHidden = true
            titleLabelTopConstraint.constant += 22
            return
        }
        if titleLabelTopConstraint.constant == 32 {
            titleLabelTopConstraint.constant = 10
            subtitleLabel.isHidden = false
        }
        subtitleLabel.text = subtitleText
    }

}
