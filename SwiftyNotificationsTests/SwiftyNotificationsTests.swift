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
    
}
