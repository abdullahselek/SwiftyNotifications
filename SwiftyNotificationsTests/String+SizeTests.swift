//
//  String+SizeTests.swift
//  SwiftyNotifications
//
//  Created by Selek, Abdullah on 13.09.17.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import XCTest

@testable import SwiftyNotifications

class String_SizeTests: XCTestCase {
    
    func testStringHeight() {
        let string = "string"
        let height = string.height(withConstrainedWidth: 40.0, font: UIFont.boldSystemFont(ofSize: 16.0))
        XCTAssertEqual(height, 39.0)
    }

    func testStringWidth() {
        let string = "string"
        let height = string.width(withConstraintedHeight: 18.0, font: UIFont.boldSystemFont(ofSize: 16.0))
        XCTAssertEqual(height, 45.0)
    }
}
