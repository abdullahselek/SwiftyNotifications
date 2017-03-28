//
//  SwiftyNotificationsDrawingsTests.swift
//  SwiftyNotifications
//
//  Created by Abdullah Selek on 28/03/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import XCTest

@testable import SwiftyNotifications;

class SwiftyNotificationsDrawingsTests: XCTestCase {
        
    func testCreateCheckmarkImage() {
        let checkmark = SwiftyNotificationsDrawings.checkMarkImage(color: UIColor.white)
        XCTAssertNotNil(checkmark)
    }

    func testCreateCrossImage() {
        let cross = SwiftyNotificationsDrawings.crossImage(color: UIColor.white)
        XCTAssertNotNil(cross)
    }
    
}
