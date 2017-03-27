//
//  RoundedViewTests.swift
//  SwiftyNotifications
//
//  Created by Abdullah Selek on 27/03/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import XCTest

@testable import SwiftyNotifications;

class RoundedViewTests: XCTestCase {

    func testMakeRound() {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
        view.makeRound()
        XCTAssertEqual(view.frame, CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
        XCTAssertEqual(view.layer.cornerRadius, view.frame.width / 2)
    }

}
