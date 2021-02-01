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
    
    func testCoordinator_whenInitWithRouter_shouldNotBeNil() {
        XCTAssertNotNil(coordinatorMock)
    }
    
    func testCoordinator_whenInitWithRouter_routerInCoordinatorShouldNotBeNil() {
        XCTAssertNotNil(coordinatorMock.router)
    }
    
    func testCoordinator_whenInitWithRouter_childrenInCoordinatorShouldBeEqualZero() {
        XCTAssertEqual(coordinatorMock.children.count, 0)
    }
    
    func testCoordinator_whenCallShowMethod_shouldCallsRouterShowMethod() {
        // when
        coordinatorMock.show(animated: true) { }
        // then
        XCTAssertTrue(routerMock.showWithOnDismissedWasCalled)
    }
    
    func testCoordinator_whenCallShowMethodWithOnDismissedArgument_shouldSetOnDismissedToRouter() {
        // when
        coordinatorMock.show(animated: true) { }
        // then
        XCTAssertNotNil(routerMock.onDismissed)
    }
    
    func testCoordinator_whenCallShowMethodWithoutOnDismissedArgument_onDismissedInRouterShouldBeNil() {
        // when
        coordinatorMock.show(animated: true, onDismissed: nil)
        // then
        XCTAssertNil(routerMock.onDismissed)
    }
    
    func testCoordinator_whenCallsHide_routerShouldCallsHide() {
        // when
        coordinatorMock.hide(animated: true)
        // then
        XCTAssertTrue(routerMock.hideWasCalled)
    }
    
    func testCoordinator_whenCallsShowChild_childrenCountInCoordinatorShouldBeOne() {
        // given
        let router = RouterMock()
        let coordinator = CoordinatorMock(router: router)
        // when
        coordinatorMock.showChild(coordinator, animated: true)
        // then
        XCTAssertEqual(coordinatorMock.children.count, 1)
    }
    
    func testCoordinator_whenCallsShowChild_childCoordinatorShouldCallsShowMethod() {
        // given
        let router = RouterMock()
        let coordinator = CoordinatorMock(router: router)
        // when
        coordinatorMock.showChild(coordinator, animated: true)
        // then
        XCTAssertTrue(coordinator.showWasCalled)
    }
    
    func testCoordinator_whenCallsShowChild_routerShouldCallsShowWithOnDismissedMethod() {
        // given
        let router = RouterMock()
        let coordinator = CoordinatorMock(router: router)
        // when
        coordinatorMock.showChild(coordinator, animated: true)
        // then
        XCTAssertTrue(router.showWithOnDismissedWasCalled)
    }
    
    func testCoordinator_whenCallsHideAndChildCoordinatorHasOnlyOneVC_childCoordinatorShouldBeRemovedFromChildrenOfItsParent() {
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

