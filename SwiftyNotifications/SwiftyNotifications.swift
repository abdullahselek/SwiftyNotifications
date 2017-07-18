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
}

@objc public protocol SwiftyNotificationsDelegate: class {

    @objc optional func willShowNotification(notification: SwiftyNotifications)
    @objc optional func didShowNotification(notification: SwiftyNotifications)
    @objc optional func willDismissNotification(notification: SwiftyNotifications)
    @objc optional func didDismissNotification(notification: SwiftyNotifications)

}

public typealias SwiftyNotificationsTouchHandler = () -> Void

public class SwiftyNotifications: UIView {

    @IBOutlet public weak var contentView: UIView!
    @IBOutlet public weak var leftAccessoryView: UIImageView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var subtitleLabel: UILabel!

    public var delegate: SwiftyNotificationsDelegate?

    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtitleLabelBottomConstraint: NSLayoutConstraint!

    private var blurView: UIVisualEffectView!
    private var vibrancyView: UIVisualEffectView!

    private var style: SwiftyNotificationsStyle!
    private var fromTop: Bool!
    private var dismissDelay: TimeInterval?
    private var dismissTimer: Timer?
    private var touchHandler: SwiftyNotificationsTouchHandler?
    private var topConstraint: NSLayoutConstraint!

    internal static let notificationHeight = CGFloat(85.0)

    class func instanceFromNib() -> SwiftyNotifications {
        let bundle = Bundle(for: self.classForCoder())
        return bundle.loadNibNamed("SwiftyNotifications", owner: nil, options: nil)?.first as! SwiftyNotifications
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public static func withStyle(style: SwiftyNotificationsStyle,
                                 title: String,
                                 subtitle: String) -> SwiftyNotifications {
        let notification = SwiftyNotifications.withStyle(style: style,
                                                         title: title,
                                                         subtitle: subtitle,
                                                         dismissDelay: 0)
        return notification
    }

    public static func withStyle(style: SwiftyNotificationsStyle,
                                 title: String,
                                 subtitle: String,
                                 dismissDelay: TimeInterval) -> SwiftyNotifications {
        let notification = SwiftyNotifications.withStyle(style: style,
                                                         title: title,
                                                         subtitle: subtitle,
                                                         dismissDelay: dismissDelay,
                                                         touchHandler: nil)
        return notification
    }

    public static func withStyle(style: SwiftyNotificationsStyle,
                                 title: String,
                                 subtitle: String,
                                 dismissDelay: TimeInterval,
                                 touchHandler: SwiftyNotificationsTouchHandler?) -> SwiftyNotifications {
        let notification = SwiftyNotifications.instanceFromNib()
        notification.leftAccessoryView.makeRound()
        notification.translatesAutoresizingMaskIntoConstraints = false
        if dismissDelay > 0 {
            notification.dismissDelay = dismissDelay
        }
        if touchHandler != nil {
            notification.touchHandler = touchHandler
            let tapHandler = UITapGestureRecognizer(target: notification, action: #selector(SwiftyNotifications.handleTap))
            notification.addGestureRecognizer(tapHandler)
        }
        notification.setTitle(title: title, subtitle: subtitle)
        notification.customize(style: style)
        return notification
    }

    public func show() {
        if canDisplay() {
            self.delegate?.willShowNotification?(notification: self)
            updateTopConstraint(hide: false)
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .allowAnimatedContent, animations: { 
                self.superview?.layoutIfNeeded()
            }, completion: { (finished) in
                if self.dismissDelay != nil && self.dismissDelay! > 0 {
                    self.dismissTimer = Timer.scheduledTimer(timeInterval: self.dismissDelay!,
                                                             target: self,
                                                             selector: #selector(SwiftyNotifications.dismiss),
                                                             userInfo: nil,
                                                             repeats: false)
                }
                self.delegate?.didShowNotification?(notification: self)
            })
        } else {
            NSException(name: NSExceptionName.internalInconsistencyException,
                        reason: "Must have a superview before calling show",
                        userInfo: nil).raise()
        }
    }

    public func dismiss() {
        self.delegate?.willDismissNotification?(notification: self)
        if self.dismissTimer != nil {
            self.dismissTimer!.invalidate()
            self.dismissTimer = nil
        }
        updateTopConstraint(hide: true)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .allowAnimatedContent, animations: {
            self.superview?.layoutIfNeeded()
        }, completion: { (finished) in
            self.delegate?.didDismissNotification?(notification: self)
        })
    }

    public func customize(style: SwiftyNotificationsStyle) {
        switch style {
        case .custom:
            let primaryColor = UIColor.white
            let secondaryColor = UIColor.black
            self.contentView.backgroundColor = primaryColor
            self.titleLabel.textColor = secondaryColor
            self.subtitleLabel.textColor = secondaryColor
            break
        case .error:
            let primaryColor = UIColor.snRedColor()
            let secondaryColor = UIColor.snWhiteColor()
            self.contentView.backgroundColor = primaryColor
            self.titleLabel.textColor = secondaryColor
            self.subtitleLabel.textColor = secondaryColor
            break
        case .success:
            let primaryColor = UIColor.snGreenColor()
            let secondaryColor = UIColor.snWhiteColor()
            self.contentView.backgroundColor = primaryColor
            self.titleLabel.textColor = secondaryColor
            self.subtitleLabel.textColor = secondaryColor
            break
        case .info:
            let primaryColor = UIColor.snOrangeColor()
            let secondaryColor = UIColor.snWhiteColor()
            self.contentView.backgroundColor = primaryColor
            self.titleLabel.textColor = secondaryColor
            self.subtitleLabel.textColor = secondaryColor
            break
        case .warning:
            let primaryColor = UIColor.snYellowColor()
            let secondaryColor = UIColor.snBlackColor()
            self.contentView.backgroundColor = primaryColor
            self.titleLabel.textColor = secondaryColor
            self.subtitleLabel.textColor = secondaryColor
            break
        case .normal:
            let primaryColor = UIColor.snBlueColor()
            let secondaryColor = UIColor.snWhiteColor()
            self.contentView.backgroundColor = primaryColor
            self.titleLabel.textColor = secondaryColor
            self.subtitleLabel.textColor = secondaryColor
            break
        }
        setAccessoryView(style: style)
    }

    public func setTitle(title: String, subtitle: String?) {
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

    public func setCustomColors(backgroundColor: UIColor, textColor: UIColor) {
        contentView.backgroundColor = backgroundColor
        leftAccessoryView.backgroundColor = backgroundColor
        titleLabel.textColor = textColor
        subtitleLabel.textColor = textColor
    }

    public func addTouchHandler(touchHandler: @escaping SwiftyNotificationsTouchHandler) {
        self.touchHandler = touchHandler
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(SwiftyNotifications.handleTap))
        addGestureRecognizer(tapHandler)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview == nil {
            return
        }
        updateTopConstraint(hide: true)
    }

    internal func updateTopConstraint(hide: Bool) {
        let constant = hide == true ? -SwiftyNotifications.notificationHeight : 0
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
            superview?.addConstraint(topConstraint)
        }
    }

    internal func addBlurView(blurStyle: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let visualEffect = UIVibrancyEffect(blurEffect: blurEffect)
        vibrancyView = UIVisualEffectView(effect: visualEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(blurView, belowSubview: contentView)
        addConstraint(NSLayoutConstraint(item: blurView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .height,
                                         multiplier: 1.0,
                                         constant: 0.0))
        addConstraint(NSLayoutConstraint(item: blurView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0.0))
        insertSubview(vibrancyView, belowSubview: contentView)
        addConstraint(NSLayoutConstraint(item: vibrancyView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .height,
                                         multiplier: 1.0,
                                         constant: 0.0))
        addConstraint(NSLayoutConstraint(item: vibrancyView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0.0))
    }

    internal func removeBlurViews() {
        if blurView != nil && subviews.contains(blurView) {
            blurView.removeFromSuperview()
            blurView = nil
        }
        if vibrancyView != nil && subviews.contains(vibrancyView) {
            vibrancyView.removeFromSuperview()
            vibrancyView = nil
        }
    }

    internal func setAccessoryView(style: SwiftyNotificationsStyle) {
        var accessoryImage: UIImage!
        switch style {
        case .error:
            accessoryImage = SwiftyNotificationsDrawings.crossImage(color: UIColor.snRedColor())
            leftAccessoryView.backgroundColor = UIColor.snWhiteColor()
            break
        case .success:
            accessoryImage = SwiftyNotificationsDrawings.checkMarkImage(color: UIColor.snGreenColor())
            leftAccessoryView.backgroundColor = UIColor.snWhiteColor()
            break
        case .info:
            accessoryImage = SwiftyNotificationsDrawings.infoImage(color: UIColor.snOrangeColor())
            leftAccessoryView.backgroundColor = UIColor.snWhiteColor()
            break
        case .warning:
            accessoryImage = SwiftyNotificationsDrawings.warningImage(backgroundColor: UIColor.snYellowColor(),
                                                             foregroundColor: UIColor.snBlackColor())
            leftAccessoryView.backgroundColor = UIColor.snBlackColor()
            break
        case .normal:
            accessoryImage = SwiftyNotificationsDrawings.infoImage(color: UIColor.snBlueColor())
            leftAccessoryView.backgroundColor = UIColor.snWhiteColor()
            break
        default:
            break
        }
        if accessoryImage != nil {
            let image = accessoryImage.scaleImageToFitSize(size: CGSize(width: 45.0, height: 45.0))
            leftAccessoryView.image = image
        }
    }

    internal func handleTap() {
        touchHandler?()
    }

    internal func canDisplay() -> Bool {
        return self.superview != nil ? true : false
    }

}
