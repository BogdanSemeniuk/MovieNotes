//
//  MainCoordinatorTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 29.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class MainCoordinatorTests: XCTestCase {
    
    var sut: MainCoordinator!
    var mainRouter: MainRouter!

    override func setUpWithError() throws {
        mainRouter = MainRouter(window: UIWindow())
        sut = MainCoordinator(router: mainRouter)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testMainCoordinator_whenInitWithRouter_shouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testMainCoordinator_whenInitWithRouter_routerShouldNotBeNil() {
        XCTAssertNotNil(sut.router)
    }
    
    func testMainCoordinator_whenInitWithRouter_childrenCountShouldBeEqualZero() {
        XCTAssertEqual(sut.children.count, 0)
    }
    
    func testMainCoordinator_whenShow_windowRootViewControllerTypeIsUITabBarController() {
        // when
        sut.show(animated: true, onDismissed: nil)
        guard let rootViewController = mainRouter.window.rootViewController else { XCTFail("RootViewController can't be nil"); return }
        // then
        XCTAssertTrue(rootViewController.isKind(of: UITabBarController.self))
    }
    
    func testMainCoordinator_whenShow_childrenCountShouldBeEqualTwo() {
        // when
        sut.show(animated: true, onDismissed: nil)
        // then
        XCTAssertEqual(sut.children.count, 2)
    }
    
    func testMainCoordinator_whenShow_windowRootViewControllerHasTwoTabs() {
        // when
        sut.show(animated: true, onDismissed: nil)
        guard let rootViewController = mainRouter.window.rootViewController as? UITabBarController else { XCTFail("RootViewController must has UITabBarController type"); return }
        // then
        XCTAssertEqual(rootViewController.viewControllers?.count, 2)
    }
    
    func testMainCoordinator_whenShow_windowRootViewControllerShouldContainsMoviesListViewController() {
        // when
        sut.show(animated: true, onDismissed: nil)
        
        guard let navigationControllers = (mainRouter.window.rootViewController as? UITabBarController)?.viewControllers as? [UINavigationController] else { XCTFail("RootViewController must has array of NavigationControllers"); return }
        let viewControllers = navigationControllers.map({ $0.viewControllers.first ?? UIViewController() })
        let moviesListViewController = viewControllers.filter({ $0.isKind(of: MoviesListViewController.self) })
        // then
        XCTAssertNotNil(moviesListViewController)
    }
    
    func testMainCoordinator_whenShow_windowRootViewControllerShouldContainsActivitiesViewController() {
        // when
        sut.show(animated: true, onDismissed: nil)
        
        guard let navigationControllers = (mainRouter.window.rootViewController as? UITabBarController)?.viewControllers as? [UINavigationController] else { XCTFail("RootViewController must has array of NavigationControllers"); return }
        let viewControllers = navigationControllers.map({ $0.viewControllers.first ?? UIViewController() })
        let activitiesViewController = viewControllers.filter({ $0.isKind(of: ActivitiesViewController.self) })
        // then
        XCTAssertNotNil(activitiesViewController)
    }
    
    func testMainCoordinator_whenShow_childrenShouldContainMoviesCoordinator() {
        // when
        sut.show(animated: true, onDismissed: nil)
        let moviesCoordinator = sut.children.filter({ ($0 as? MoviesCoordinator) != nil }).first
        // then
        XCTAssertNotNil(moviesCoordinator)
    }
    
    func testMainCoordinator_whenShow_childrenShouldContainActivitiesCoordinator() {
        // when
        sut.show(animated: true, onDismissed: nil)
        let activitiesCoordinator = sut.children.filter({ ($0 as? ActivitiesCoordinator) != nil }).first
        // then
        XCTAssertNotNil(activitiesCoordinator)
    }
}
