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

    var mockRouter: MockRouter!
    
    override func setUpWithError() throws {
        mockRouter = MockRouter()
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
        XCTAssertTrue(mockRouter.funcShowWithOnDismissedWasCalled)
    }
}

extension RouterTests {
    final class MockRouter: Router {
        private(set) var onDismissed: (() -> Void)?
        private(set) var funcShowWithOnDismissedWasCalled = false
        
        func show(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
            self.onDismissed = onDismissed
            funcShowWithOnDismissedWasCalled.toggle()
        }
        
        func hide(animated: Bool) {}
    }
}
