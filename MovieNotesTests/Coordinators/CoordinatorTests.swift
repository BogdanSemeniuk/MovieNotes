//
//  CoordinatorTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class CoordinatorTests: XCTestCase {
    var coordinatorMock: CoordinatorMock!
    var routerMock: RouterMock!
    
    override func setUpWithError() throws {
        routerMock = RouterMock()
        coordinatorMock = CoordinatorMock(router: routerMock)
    }

    override func tearDownWithError() throws {
        routerMock = nil
        coordinatorMock = nil
    }
    
    func testCoordinatorExistAfterInitWithRouter() {
        XCTAssertNotNil(coordinatorMock)
    }
    
    func testRouterSetAfterInit() {
        XCTAssertNotNil(coordinatorMock.router)
    }
    
    func testChildrenCountEqualZeroAfterInit() {
        XCTAssertEqual(coordinatorMock.children.count, 0)
    }
    
    func testCoordinatorShowMethodCallsRouterShowMethod() {
        // when
        coordinatorMock.show(animated: true) { }
        // then
        XCTAssertTrue(routerMock.showWithOnDismissedWasCalled)
    }
    
    func testCoordinatorShowMethodPassOnDismissedComletionToRouterShowMethod() {
        // when
        coordinatorMock.show(animated: true) { }
        // then
        XCTAssertNotNil(routerMock.onDismissed)
    }
    
    func testCoordinatorShowMethodWithNilOnDismissedComletionCallRouterShowMethodWithNilOnDismissedComletion() {
        // when
        coordinatorMock.show(animated: true, onDismissed: nil)
        // then
        XCTAssertNil(routerMock.onDismissed)
    }
    
    func testCoordinatorHideMethodCallsRouterHideMethod() {
        // when
        coordinatorMock.hide(animated: true)
        // then
        XCTAssertTrue(routerMock.hideWasCalled)
    }
    
    func testShowChildMethodAddNewCoordinatorToChildren() {
        // given
        let router = RouterMock()
        let coordinator = CoordinatorMock(router: router)
        // when
        coordinatorMock.showChild(coordinator, animated: true)
        // then
        XCTAssertEqual(coordinatorMock.children.count, 1)
    }
    
    func testWhenCoordinatorShowChildMethodThenRouterCallsShowWithOnDismissedMethod() {
        // given
        let router = RouterMock()
        let coordinator = CoordinatorMock(router: router)
        // when
        coordinatorMock.showChild(coordinator, animated: true)
        // then
        XCTAssertTrue(router.showWithOnDismissedWasCalled)
    }
    
    func testWhenHideMethodOfChildCoordinatorCallsThenThisChildWillBeRemovedFromChildrenOfItsParent() {
        // given
        let router = RouterMock()
        let coordinator = CoordinatorMock(router: router)
        coordinatorMock.showChild(coordinator, animated: true)
        // when
        coordinator.hide(animated: true)
        // then
        XCTAssertEqual(coordinatorMock.children.count, 0)
    }
}

