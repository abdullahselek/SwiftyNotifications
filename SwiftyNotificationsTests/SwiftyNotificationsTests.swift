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

    func testInstanceFromNib() {
        let swiftNotifications = SwiftyNotifications.instanceFromNib() as! SwiftyNotifications
        XCTAssertNotNil(swiftNotifications)
        XCTAssertNotNil(swiftNotifications.leftAccessoryView)
        XCTAssertNotNil(swiftNotifications.titleLabel)
        XCTAssertNotNil(swiftNotifications.subtitleLabel)
    }
    
}
