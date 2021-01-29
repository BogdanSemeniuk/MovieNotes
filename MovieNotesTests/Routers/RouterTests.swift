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

    var routerMock: RouterMock!
    
    override func setUpWithError() throws {
        routerMock = RouterMock()
    }

    override func tearDownWithError() throws {
        routerMock = nil
    }
    
    func testRouterMock_whenCallFuncShowWithoutOnDismissedArgument_onDismissedShouldBeNil() {
        // when
        routerMock.show(UIViewController(), animated: true)
        // then
        XCTAssertNil(routerMock.onDismissed)
    }
    
    func testRouterMock_whenCallFuncShowWithOnDismissedArgument_onDismissedShouldNotBeNil() {
        // when
        routerMock.show(UIViewController(), animated: true) { }
        // then
        XCTAssertNotNil(routerMock.onDismissed)
    }
    
    func testRouterMock_whenCallFuncShowWithoutOnDismissedArgument_shouldCallFuncShowWithOnDismissed() {
        // when
        routerMock.show(UIViewController(), animated: true)
        // then
        XCTAssertTrue(routerMock.showWithOnDismissedWasCalled)
    }
}
