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

}
