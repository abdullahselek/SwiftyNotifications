//
//  SwiftyNotificationsTests.swift
//  SwiftyNotificationsTests
//
//  Created by Abdullah Selek on 27/03/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import XCTest

@testable import SwiftyNotifications

class SwiftyNotificationsTests: XCTestCase {

    var swiftNotifications: SwiftyNotifications!

    override func setUp() {
        swiftNotifications = SwiftyNotifications.instanceFromNib() as! SwiftyNotifications
    }

    func testInstanceFromNib() {
        XCTAssertNotNil(swiftNotifications)
        XCTAssertNotNil(swiftNotifications.leftAccessoryView)
        XCTAssertNotNil(swiftNotifications.titleLabel)
        XCTAssertNotNil(swiftNotifications.subtitleLabel)
    }

    func testSetTitleAndSubtitle_whenSubtitleIsEmpty() {
        XCTAssertNotNil(swiftNotifications)
        swiftNotifications.setTitle(title: "Title", subtitle: nil)
        XCTAssertEqual(swiftNotifications.titleLabel.text, "Title")
        XCTAssertEqual(swiftNotifications.titleLabelTopConstraint.constant, 32)
        XCTAssertTrue(swiftNotifications.subtitleLabel.isHidden)
    }

    func testSetTitleAndSubtitle_whenSubtitleNotEmpty() {
        XCTAssertNotNil(swiftNotifications)
        swiftNotifications.setTitle(title: "Title", subtitle: "Subtitle")
        XCTAssertEqual(swiftNotifications.titleLabel.text, "Title")
        XCTAssertEqual(swiftNotifications.titleLabelTopConstraint.constant, 10)
        XCTAssertEqual(swiftNotifications.subtitleLabel.text, "Subtitle")
        XCTAssertFalse(swiftNotifications.subtitleLabel.isHidden)
    }

    func testSetTitleAndSubtitle_withEmptySubtitle_thenNotEmptySubtitle() {
        XCTAssertNotNil(swiftNotifications)
        swiftNotifications.setTitle(title: "Title", subtitle: nil)
        XCTAssertEqual(swiftNotifications.titleLabel.text, "Title")
        XCTAssertEqual(swiftNotifications.titleLabelTopConstraint.constant, 32)
        swiftNotifications.setTitle(title: "Title", subtitle: "Subtitle")
        XCTAssertFalse(swiftNotifications.subtitleLabel.isHidden)
        XCTAssertEqual(swiftNotifications.titleLabel.text, "Title")
        XCTAssertEqual(swiftNotifications.titleLabelTopConstraint.constant, 10)
        XCTAssertEqual(swiftNotifications.subtitleLabel.text, "Subtitle")
        XCTAssertFalse(swiftNotifications.subtitleLabel.isHidden)
    }

    func testAddBlurView() {
        XCTAssertNotNil(swiftNotifications)
        let subviewCount = swiftNotifications.subviews.count
        swiftNotifications.addBlurView(blurStyle: .dark)
        let newSubviewCount = swiftNotifications.subviews.count
        XCTAssertEqual(newSubviewCount, subviewCount + 2)
    }

    func testRemoveBlurViews() {
        XCTAssertNotNil(swiftNotifications)
        swiftNotifications.addBlurView(blurStyle: .dark)
        let subviewCount = swiftNotifications.subviews.count
        swiftNotifications.removeBlurViews()
        let newSubviewCount = swiftNotifications.subviews.count
        XCTAssertEqual(newSubviewCount, subviewCount - 2)
    }

    func testInit() {
        let frame = CGRect(x: 0.0,
                            y: 0.0,
                            width: 200.0,
                            height: 80)
        let notification = SwiftyNotifications(frame: frame)
        XCTAssertNotNil(notification)
        XCTAssertEqual(notification.frame, frame)
    }

    func testWithStyle_whenAllParametersSet() {
        let notification = SwiftyNotifications.withStyle(style: .info, title: "Title", subtitle: "Subtitle", dismissDelay: 2.0) {

        }
        XCTAssertNotNil(notification)
        XCTAssertEqual(notification.titleLabel.text, "Title")
        XCTAssertEqual(notification.subtitleLabel.text, "Subtitle")
    }

    func testCustomizeWithBlurDark() {
        let subviewCount = swiftNotifications.subviews.count
        swiftNotifications.customize(style: .blurDark)
        let newSubviewCount = swiftNotifications.subviews.count
        XCTAssertEqual(swiftNotifications.backgroundColor, UIColor.clear)
        XCTAssertEqual(swiftNotifications.titleLabel.textColor, UIColor.white)
        XCTAssertEqual(swiftNotifications.subtitleLabel.textColor, UIColor.white)
        XCTAssertEqual(newSubviewCount, subviewCount + 2)
    }

    func testCustomizeWithBlurLight() {
        let subviewCount = swiftNotifications.subviews.count
        swiftNotifications.customize(style: .blurLight)
        let newSubviewCount = swiftNotifications.subviews.count
        XCTAssertEqual(swiftNotifications.backgroundColor, UIColor.clear)
        XCTAssertEqual(swiftNotifications.titleLabel.textColor, UIColor.black)
        XCTAssertEqual(swiftNotifications.subtitleLabel.textColor, UIColor.black)
        XCTAssertEqual(newSubviewCount, subviewCount + 2)
    }

    func testCustomizeWithCustom() {
        let subviewCount = swiftNotifications.subviews.count
        swiftNotifications.customize(style: .blurLight)
        swiftNotifications.customize(style: .custom)
        let newSubviewCount = swiftNotifications.subviews.count
        XCTAssertEqual(swiftNotifications.backgroundColor, UIColor.white)
        XCTAssertEqual(swiftNotifications.titleLabel.textColor, UIColor.black)
        XCTAssertEqual(swiftNotifications.subtitleLabel.textColor, UIColor.black)
        XCTAssertEqual(newSubviewCount, subviewCount)
    }

    func testCustomizeWithError() {
        swiftNotifications.customize(style: .error)
        XCTAssertEqual(swiftNotifications.backgroundColor, UIColor.snRedColor())
        XCTAssertEqual(swiftNotifications.titleLabel.textColor, UIColor.snWhiteColor())
        XCTAssertEqual(swiftNotifications.subtitleLabel.textColor, UIColor.snWhiteColor())
    }

}
