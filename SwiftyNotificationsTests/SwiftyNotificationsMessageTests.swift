//
//  SwiftyNotificationsMessageTests.swift
//  SwiftyNotifications
//
//  Created by Selek, Abdullah on 13.09.17.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import XCTest

@testable import SwiftyNotifications

class SwiftyNotificationsMessageTests: XCTestCase {

    var swiftyNotificationsMessage: SwiftyNotificationsMessage!

    override func setUp() {
        swiftyNotificationsMessage = SwiftyNotificationsMessage.instanceFromNib()
        swiftyNotificationsMessage.direction = .top
    }

    func testInstanceFromNib() {
        XCTAssertNotNil(swiftyNotificationsMessage)
        XCTAssertNotNil(swiftyNotificationsMessage.messageLabel)
    }

    func testInitWithThreeParameters() {
        let swiftyNotificationsMessage = SwiftyNotificationsMessage.withBackgroundColor(color: UIColor.black,
                                                                                        message: "message",
                                                                                        direction: .top)
        XCTAssertNotNil(swiftyNotificationsMessage)
        XCTAssertEqual(swiftyNotificationsMessage.backgroundColor, UIColor.black)
    }

    func testInitWithFourParameters() {
        let swiftyNotificationsMessage = SwiftyNotificationsMessage.withBackgroundColor(color: UIColor.black,
                                                                                        message: "message",
                                                                                        dismissDelay: 1.0,
                                                                                        direction: .bottom)
        XCTAssertNotNil(swiftyNotificationsMessage)
        XCTAssertEqual(swiftyNotificationsMessage.backgroundColor, UIColor.black)
    }

    func testInitWithFiveParameters() {
        let swiftyNotificationsMessage = SwiftyNotificationsMessage.withBackgroundColor(color: UIColor.black,
                                                                                        message: "message",
                                                                                        dismissDelay: 1.0,
                                                                                        direction: .top,
                                                                                        touchHandler: {
                                                                                            
        })
        XCTAssertNotNil(swiftyNotificationsMessage)
        XCTAssertEqual(swiftyNotificationsMessage.backgroundColor, UIColor.black)
    }

    func testSetMessage() {
        let message = "message"
        swiftyNotificationsMessage.setMessage(message: message)
        XCTAssertEqual(swiftyNotificationsMessage.messageLabel.text, message)
    }

    func testUpdateTopConstraintforHiding() {
        let viewController = UIViewController()
        viewController.view.addSubview(swiftyNotificationsMessage)
        let _ = viewController.view
        let constraintCount = viewController.view.constraints.count
        XCTAssertEqual(constraintCount, 2)
        swiftyNotificationsMessage.updateTopConstraint(hide: true)
        let constraint = viewController.view.constraints[0]
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.firstItem as? SwiftyNotificationsMessage, swiftyNotificationsMessage)
        XCTAssertEqual(constraint.constant, -swiftyNotificationsMessage.frame.size.height)
    }

    func testUpdateTopConstraintforDisplaying() {
        let viewController = UIViewController()
        viewController.view.addSubview(swiftyNotificationsMessage)
        let _ = viewController.view
        let constraintCount = viewController.view.constraints.count
        XCTAssertEqual(constraintCount, 2)
        swiftyNotificationsMessage.updateTopConstraint(hide: false)
        let constraint = viewController.view.constraints[0]
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.firstItem as? SwiftyNotificationsMessage, swiftyNotificationsMessage)
        XCTAssertEqual(constraint.constant, 0)
    }

    func testUpdateBottomConstraintforHiding() {
        let viewController = UIViewController()
        viewController.view.addSubview(swiftyNotificationsMessage)
        let _ = viewController.view
        let constraintCount = viewController.view.constraints.count
        XCTAssertEqual(constraintCount, 2)
        swiftyNotificationsMessage.updateBottomConstraint(hide: true)
        let constraint = viewController.view.constraints[2]
        XCTAssertEqual(constraint.firstAttribute, .bottom)
        XCTAssertEqual(constraint.firstItem as? SwiftyNotificationsMessage, swiftyNotificationsMessage)
        XCTAssertEqual(constraint.constant, swiftyNotificationsMessage.frame.size.height)
    }

    func testUpdateBottomConstraintforDisplaying() {
        let viewController = UIViewController()
        viewController.view.addSubview(swiftyNotificationsMessage)
        let _ = viewController.view
        let constraintCount = viewController.view.constraints.count
        XCTAssertEqual(constraintCount, 2)
        swiftyNotificationsMessage.updateBottomConstraint(hide: false)
        let constraint = viewController.view.constraints[2]
        XCTAssertEqual(constraint.firstAttribute, .bottom)
        XCTAssertEqual(constraint.firstItem as? SwiftyNotificationsMessage, swiftyNotificationsMessage)
        XCTAssertEqual(constraint.constant, 0)
    }

    func testCanDisplay_whenSuperViewNil() {
        XCTAssertFalse(swiftyNotificationsMessage.canDisplay())
    }

    func testCanDisplay_whenSuperViewNotNil() {
        let viewController = UIViewController()
        viewController.view.addSubview(swiftyNotificationsMessage)
        let _ = viewController.view
        XCTAssertTrue(swiftyNotificationsMessage.canDisplay())
    }

    func testAddTouchHandler() {
        swiftyNotificationsMessage.addTouchHandler {

        }
        let gesturesCount = swiftyNotificationsMessage.gestureRecognizers?.count
        XCTAssertEqual(gesturesCount, 1)
    }

}
