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

    public var titleLabel: UILabel!
    public var subtitleLabel: UILabel!
    public var leftAccessoryView: UIView!
    public var rightAccessoryView: UIView!
    public var style: SwiftyNotificationsStyle!
    public var fromTop: Bool!
    public var delegate: SwiftyNotificationsDelegate!

}
