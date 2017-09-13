//
//  SwiftyNotificationsMessage.swift
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

class SwiftyNotificationsMessage: UIView {

    @IBOutlet public weak var messageLabel: UILabel!

    public var delegate: SwiftyNotificationsDelegate?
    public var direction: SwiftyNotificationsDirection!

    private var dismissDelay: TimeInterval?
    private var dismissTimer: Timer?
    private var touchHandler: SwiftyNotificationsTouchHandler?

    class func instanceFromNib() -> SwiftyNotificationsMessage {
        let bundle = Bundle(for: self.classForCoder())
        return bundle.loadNibNamed("SwiftyNotificationsMessage",
                                   owner: nil,
                                   options: nil)?.first as! SwiftyNotificationsMessage
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public static func withBackgroundColor(color: UIColor,
                                           message: String,
                                           direction: SwiftyNotificationsDirection) -> SwiftyNotificationsMessage {
        let notification = SwiftyNotificationsMessage.withBackgroundColor(color: color,
                                                                          message: message,
                                                                          dismissDelay: 0,
                                                                          direction: direction)
        return notification
    }

    public static func withBackgroundColor(color: UIColor,
                                           message: String,
                                           dismissDelay: TimeInterval,
                                           direction: SwiftyNotificationsDirection) -> SwiftyNotificationsMessage {
        let notification = SwiftyNotificationsMessage.withBackgroundColor(color: color,
                                                                          message: message,
                                                                          dismissDelay: dismissDelay,
                                                                          direction: direction,
                                                                          touchHandler: nil)
        return notification
    }

    public static func withBackgroundColor(color: UIColor,
                                           message: String,
                                           dismissDelay: TimeInterval,
                                           direction: SwiftyNotificationsDirection,
                                           touchHandler: SwiftyNotificationsTouchHandler?) -> SwiftyNotificationsMessage {
        let notification = SwiftyNotificationsMessage.instanceFromNib()
        notification.direction = direction
        notification.backgroundColor = color
        notification.translatesAutoresizingMaskIntoConstraints = false
        if dismissDelay > 0 {
            notification.dismissDelay = dismissDelay
        }
        if touchHandler != nil {
            notification.touchHandler = touchHandler
            let tapHandler = UITapGestureRecognizer(target: notification, action: #selector(SwiftyNotifications.handleTap))
            notification.addGestureRecognizer(tapHandler)
        }
        return notification
    }

}
