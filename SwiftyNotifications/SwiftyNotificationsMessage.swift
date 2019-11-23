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

open class SwiftyNotificationsMessage: UIView {

    @IBOutlet open weak var messageLabel: UILabel!

    open var delegate: SwiftyNotificationsDelegate?
    open var direction: SwiftyNotificationsDirection!

    private var dismissDelay: TimeInterval?
    private var dismissTimer: Timer?
    private var touchHandler: SwiftyNotificationsTouchHandler?

    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var dynamicHeight = CGFloat(40.0)

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
            let tapHandler = UITapGestureRecognizer(target: notification, action: #selector(handleTap))
            notification.addGestureRecognizer(tapHandler)
        }
        notification.setMessage(message: message)
        return notification
    }

    open func setMessage(message: String) {
        let height = message.height(withConstrainedWidth: messageLabel.frame.size.width, font: messageLabel.font)
        messageLabel.text = message
        messageLabel.frame.size.height = height
        messageLabel.frame.size.width = self.frame.size.width
        dynamicHeight = height + 20
    }

    open func addTouchHandler(touchHandler: @escaping SwiftyNotificationsTouchHandler) {
        self.touchHandler = touchHandler
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(SwiftyNotifications.handleTap))
        addGestureRecognizer(tapHandler)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview == nil {
            return
        }
        addWidthConstraint()
        self.direction == .top ? updateTopConstraint(hide: true) : updateBottomConstraint(hide: true)
    }

    internal func updateTopConstraint(hide: Bool) {
        var topSafeAreaHeight: CGFloat = 0

        if #available(iOS 11.0, *), UIApplication.shared.windows.count > 0 {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            topSafeAreaHeight = safeFrame.minY
        }

        let constant = hide == true ? -(dynamicHeight + topSafeAreaHeight) : 0
        if topConstraint != nil && (superview?.constraints.contains(topConstraint))! {
            topConstraint.constant = constant
        } else {
            topConstraint = NSLayoutConstraint(item: self,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: superview,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: constant)
            let widthConstraint = NSLayoutConstraint(item: self,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: superview,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0)
            superview?.addConstraint(topConstraint)
            superview?.addConstraint(widthConstraint)
        }
    }

    internal func updateBottomConstraint(hide: Bool) {
        var bottomSafeAreaHeight: CGFloat = 0

        if #available(iOS 11.0, *), UIApplication.shared.windows.count > 0 {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
        }

        let constant = hide == true ? dynamicHeight + bottomSafeAreaHeight : 0
        if bottomConstraint != nil && (superview?.constraints.contains(bottomConstraint))! {
            bottomConstraint.constant = constant
        } else {
            bottomConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: superview,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: constant)
            let widthConstraint = NSLayoutConstraint(item: self,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: superview,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0)
            superview?.addConstraint(bottomConstraint)
            superview?.addConstraint(widthConstraint)
        }
    }

    internal func canDisplay() -> Bool {
        return self.superview != nil ? true : false
    }

    @objc internal func handleTap() {
        touchHandler?()
    }

    open func show() {
        if canDisplay() {
            self.delegate?.willShowNotification(notification: self)
            self.direction == .top ? updateTopConstraint(hide: false) : updateBottomConstraint(hide: false)
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .allowAnimatedContent, animations: {
                self.superview?.layoutIfNeeded()
            }, completion: { (finished) in
                if self.dismissDelay != nil && self.dismissDelay! > 0 {
                    self.dismissTimer = Timer.scheduledTimer(timeInterval: self.dismissDelay!,
                                                             target: self,
                                                             selector: #selector(SwiftyNotificationsMessage.dismiss),
                                                             userInfo: nil,
                                                             repeats: false)
                }
                self.delegate?.didShowNotification(notification: self)
            })
        } else {
            NSException(name: NSExceptionName.internalInconsistencyException,
                        reason: "Must have a superview before calling show",
                        userInfo: nil).raise()
        }
    }

    @objc open func dismiss() {
        self.delegate?.willDismissNotification(notification: self)
        if self.dismissTimer != nil {
            self.dismissTimer!.invalidate()
            self.dismissTimer = nil
        }
        self.direction == .top ? updateTopConstraint(hide: true) : updateBottomConstraint(hide: true)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .allowAnimatedContent, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { (finished) in
            self.delegate?.didDismissNotification(notification: self)
        })
    }

    internal func addWidthConstraint() {
        let widthConstraint = NSLayoutConstraint(item: self,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: superview,
                                                 attribute: .width,
                                                 multiplier: 1.0,
                                                 constant: 0.0)
        superview?.addConstraint(widthConstraint)
    }

}
