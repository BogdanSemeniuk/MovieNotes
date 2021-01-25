//
//  RouterTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class RouterTests: XCTestCase {

    var mockRouter: RouterMock!
    
    override func setUpWithError() throws {
        mockRouter = RouterMock()
    }

    override func tearDownWithError() throws {
        mockRouter = nil
    }
    
    func testFuncShowWithoutOnDismissedDoesNotPassOnDismissedCompletionToFuncShowWithOnDismissed() {
        // when
        mockRouter.show(UIViewController(), animated: true)
        // then
        XCTAssertNil(mockRouter.onDismissed)
    }
    
    func testFuncShowWithoutOnDismissedCallFuncShowWithOnDismissed() {
        // when
        mockRouter.show(UIViewController(), animated: true)
        // then
        XCTAssertTrue(mockRouter.showWithOnDismissedWasCalled)
    }
}
