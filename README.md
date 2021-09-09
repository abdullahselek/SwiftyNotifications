[![SwiftyNotifications CI](https://github.com/abdullahselek/SwiftyNotifications/workflows/SwiftyNotifications%20CI/badge.svg)](https://github.com/abdullahselek/SwiftyNotifications/actions)
[![Build Status](https://travis-ci.org/abdullahselek/SwiftyNotifications.svg?branch=master)](https://travis-ci.org/abdullahselek/SwiftyNotifications)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SwiftyNotifications.svg)](http://cocoapods.org/pods/SwiftyNotifications)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Coverage Status](https://coveralls.io/repos/github/abdullahselek/SwiftyNotifications/badge.svg?branch=master)](https://coveralls.io/github/abdullahselek/SwiftyNotifications?branch=master)
![Platform](https://img.shields.io/cocoapods/p/SwiftyNotifications.svg?style=flat)
![License](https://img.shields.io/dub/l/vibe-d.svg)

![SwiftyNotifications](https://github.com/Tobaloidee/SwiftyNotifications/blob/master/Screenshots/logo/logotype.png)

Highly configurable iOS UIView for presenting notifications that doesn't block the UI.

## Screenshots
![info](https://github.com/abdullahselek/SwiftyNotifications/blob/master/Screenshots/info.png)
![error](https://github.com/abdullahselek/SwiftyNotifications/blob/master/Screenshots/error.png)
![success](https://github.com/abdullahselek/SwiftyNotifications/blob/master/Screenshots/success.png)
![warning](https://github.com/abdullahselek/SwiftyNotifications/blob/master/Screenshots/warning.png)
![custom](https://github.com/abdullahselek/SwiftyNotifications/blob/master/Screenshots/custom.png)

## Requirements

| SwiftyNotifications Version | Minimum iOS Target  | Swift Version |
|:--------------------:|:---------------------------:|:---------------------------:|
| 0.7.1 | 11.0 | 5.x |
| 0.5.3 | 9.0 | 4.2 |
| 0.5.2 | 9.0 | 4.1 |
| 0.5.1 | 8.0 | 4.0 |
| 0.4 | 8.0 | 3.x |

## CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:
```
$ gem install cocoapods
```

To integrate SwiftyNotifications into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
        pod 'SwiftyNotifications', '~>0.7.1'
end
```

Then, run the following command:
```
$ pod install
```

## Carthage

Carthage is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with Homebrew using the following command:

```
brew update
brew install carthage
```

To integrate SwiftyNotifications into your Xcode project using Carthage, specify it in your Cartfile:

```
github "abdullahselek/SwiftyNotifications" ~> 0.7.1
```

## Swift Package Manager

Modify your Package.swift file to include the following dependency:

```
.package(url: "https://github.com/abdullahselek/SwiftyNotifications.git", from: "0.7.1")
```

## XCFramework

XCFrameworks require Xcode 11 or later and integration is very similar to integration of .framework format. Please use script [scripts/build-framework.sh](scripts/build-framework.sh) to generate binary SwiftyNotifications.xcframework archive that you can use as a dependency in Xcode.

SwiftyNotifications.xcframework is a Release (Optimized) binary that offer best available Swift code performance.

## Example Usage
```
import SwiftyNotifications
````

Than initiate notification and add to your view
```
let notification = SwiftyNotifications.withStyle(style: .info,
                                                 title: "Swifty Notifications",
                                                 subtitle: "Highly configurable iOS UIView for presenting notifications that doesn't block the UI",
                                                 direction: .bottom)
view.addSubview(notification)
```

You can customize this notification anytime in your view
```
notification.customize(style: .warning)
```

and update texts
```
notification.setTitle(title: "New title", subtitle: "New subtitle")
```

To show the notification
```
notification.show()
```

To dismiss
```
notification.dismiss()
```

Creating custom notification
```
let customNotification = SwiftyNotifications.withStyle(style: .custom,
                                                       title: "Custom",
                                                       subtitle: "Custom notification with custom image and colors",
                                                       direction: .top)
customNotification.leftAccessoryView.image = UIImage(named: "apple_logo")!
customNotification.setCustomColors(backgroundColor: UIColor.cyan, textColor: UIColor.white)
view.addSubview(customNotification)
```

Other available functions for creating notifications
> With a time interval option for auto dismissing
```
let notification = SwiftyNotifications.withStyle(style: .warning,
                                                 title: "Title",
                                                 subtitle: "Subtitle",
                                                 dismissDelay: 3.0,
                                                 direction: .top)
```
> With touch handler
```
let notification = SwiftyNotifications.withStyle(style: .error,
                                                 title: "Title",
                                                 subtitle: "Subtitle",
                                                 dismissDelay: 5.0,
                                                 direction: .bottom) {
                                                            
        }
```

New class added for just displaying message
```
let swiftyNotificationsMessage = SwiftyNotificationsMessage.withBackgroundColor(color: UIColor.darkGray,
                                                                                message: "Notification with just text",
                                                                                direction: .top)
view.addSubview(swiftyNotificationsMessage)
```

To display message notification
```
swiftyNotificationsMessage.show()
```

Dismissing message notification
```
swiftyNotificationsMessage.dismiss()
```

Optional delegates that gives informations about showing and dismissing notification screen
- `func willShowNotification(notification: SwiftyNotifications)`
- `func didShowNotification(notification: SwiftyNotifications)`
- `func willDismissNotification(notification: SwiftyNotifications)`
- `func didDismissNotification(notification: SwiftyNotifications)`

Adding touch handler to catch tap gestures on notification
```
notification.addTouchHandler {

        }
```

Add a swipe gesture recognizer to dismiss notification with a swipe direction
```
notification.addSwipeGestureRecognizer(direction: .down)
```

Possible swipe directions
- right
- left
- up
- down
