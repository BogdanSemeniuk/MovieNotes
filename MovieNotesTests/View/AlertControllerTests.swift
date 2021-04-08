//
//  AlertControllerTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 08.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class AlertControllerTests: XCTestCase {
    func testAlert_whenMakeWithMessage_messageMustBeSet() throws {
        // given
        let message = "Alert message"
        // when
        let alert = UIAlertController.make(withMessage: message)
        // then
        XCTAssertNotNil(alert.message)
        XCTAssertEqual(alert.message, message)
    }
}
