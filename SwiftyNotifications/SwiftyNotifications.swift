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

public enum SwiftyNotificationsDirection {
    case top
    case bottom
}

public protocol SwiftyNotificationsDelegate: AnyObject {

    func willShowNotification(notification: UIView)
    func didShowNotification(notification: UIView)
    func willDismissNotification(notification: UIView)
    func didDismissNotification(notification: UIView)

}

public typealias SwiftyNotificationsTouchHandler = () -> Void

open class SwiftyNotifications: UIView {

    @IBOutlet open weak var contentView: UIView!
    @IBOutlet open weak var leftAccessoryView: UIImageView!
    @IBOutlet open weak var titleLabel: UILabel!
    @IBOutlet open weak var subtitleLabel: UILabel!

    open var delegate: SwiftyNotificationsDelegate?
    open var direction: SwiftyNotificationsDirection!

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
    private var bottomConstraint: NSLayoutConstraint!

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
                                 subtitle: String,
                                 direction: SwiftyNotificationsDirection) -> SwiftyNotifications {
        let notification = SwiftyNotifications.withStyle(style: style,
                                                         title: title,
                                                         subtitle: subtitle,
                                                         dismissDelay: 0,
                                                         direction: direction)
        return notification
    }

    public static func withStyle(style: SwiftyNotificationsStyle,
                                 title: String,
                                 subtitle: String,
                                 dismissDelay: TimeInterval,
                                 direction: SwiftyNotificationsDirection) -> SwiftyNotifications {
        let notification = SwiftyNotifications.withStyle(style: style,
                                                         title: title,
                                                         subtitle: subtitle,
                                                         dismissDelay: dismissDelay,
                                                         direction: direction,
                                                         touchHandler: nil)
        return notification
    }

    public static func withStyle(style: SwiftyNotificationsStyle,
                                 title: String,
                                 subtitle: String,
                                 dismissDelay: TimeInterval,
                                 direction: SwiftyNotificationsDirection,
                                 touchHandler: SwiftyNotificationsTouchHandler?) -> SwiftyNotifications {
        let notification = SwiftyNotifications.instanceFromNib()
        notification.direction = direction
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
                                                             selector: #selector(SwiftyNotifications.dismiss),
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

    open func customize(style: SwiftyNotificationsStyle) {
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

    open func setTitle(title: String, subtitle: String?) {
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

    open func setCustomColors(backgroundColor: UIColor, textColor: UIColor) {
        contentView.backgroundColor = backgroundColor
        leftAccessoryView.backgroundColor = backgroundColor
        titleLabel.textColor = textColor
        subtitleLabel.textColor = textColor
    }

    open func addTouchHandler(touchHandler: @escaping SwiftyNotificationsTouchHandler) {
        self.touchHandler = touchHandler
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(SwiftyNotifications.handleTap))
        addGestureRecognizer(tapHandler)
    }
    
    open func addSwipeGestureRecognizer(direction: UISwipeGestureRecognizer.Direction) {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        swipeGestureRecognizer.direction = direction
        self.addGestureRecognizer(swipeGestureRecognizer)
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

        if #available(iOS 11.0, *), UIApplication.shared.windows.count > 0  {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            topSafeAreaHeight = safeFrame.minY
        }

        let constant = hide == true ? -(self.frame.size.height + topSafeAreaHeight) : 0
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

    internal func updateBottomConstraint(hide: Bool) {
        var bottomSafeAreaHeight: CGFloat = 0

        if #available(iOS 11.0, *), UIApplication.shared.windows.count > 0 {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
        }

        let constant = hide == true ? self.frame.size.height + bottomSafeAreaHeight : 0
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
            superview?.addConstraint(bottomConstraint)
        }
    }

    internal func addBlurView(blurStyle: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let visualEffect = UIVibrancyEffect(blurEffect: blurEffect)
        vibrancyView = UIVisualEffectView(effect: visualEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(blurView, belowSubview: contentView)
        addConstraint(NSLayoutConstraint(item: blurView!,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .height,
                                         multiplier: 1.0,
                                         constant: 0.0))
        addConstraint(NSLayoutConstraint(item: blurView!,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0.0))
        insertSubview(vibrancyView, belowSubview: contentView)
        addConstraint(NSLayoutConstraint(item: vibrancyView!,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .height,
                                         multiplier: 1.0,
                                         constant: 0.0))
        addConstraint(NSLayoutConstraint(item: vibrancyView!,
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

    @objc internal func handleTap() {
        touchHandler?()
    }
    
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        guard let window = UIWindow.key, let view = gesture.view else {
            return
        }
        self.delegate?.willDismissNotification(notification: self)
        var frame: CGRect!
        switch gesture.direction {
        case .right:
            frame = CGRect(x: view.frame.width,
                           y: view.frame.origin.y,
                           width: view.frame.width,
                           height: view.frame.height)
            break
        case .left:
            frame = CGRect(x: -view.frame.width,
                           y: view.frame.origin.y,
                           width: view.frame.width,
                           height: view.frame.height)
            break
        case .up:
            frame = CGRect(x: 0.0,
                           y:-view.frame.height,
                           width: view.frame.width,
                           height: view.frame.height)
            break
        case .down:
            frame = CGRect(x: 0.0,
                           y: window.frame.height + view.frame.height,
                           width: view.frame.width,
                           height: view.frame.height)
            break
        default:
            break
        }
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .allowAnimatedContent, animations: {
            view.frame = frame
        }, completion: { (finished) in
            self.delegate?.didDismissNotification(notification: self)
        })
    }

    internal func canDisplay() -> Bool {
        return self.superview != nil ? true : false
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
