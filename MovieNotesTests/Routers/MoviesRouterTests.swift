//
//  MoviesRouterTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 01.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class MoviesRouterTests: XCTestCase {
    var sut: MoviesRouter!
    var navigationController: UINavigationController?

    override func setUpWithError() throws {
        navigationController = UINavigationController()
        sut = MoviesRouter(navigationController: navigationController!)
    }

    override func tearDownWithError() throws {
        navigationController = nil
        sut = nil
    }
    
    func testMoviesRouter_whenInitWithNavigationController_shouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testMoviesRouter_whenInitWithNavigationController_navigationControllerInRouterShouldNotBeNil() {
        XCTAssertNotNil(sut.navigationController)
    }
    
    func testMoviesRouter_whenCallsShow_viewControllerShouldBeFirstViewControllerOfNavigationController() {
        // given
        let vc = UIViewController()
        // when
        sut.show(vc, animated: false)
        // then
        XCTAssertEqual(sut.navigationController.viewControllers.first, vc)
    }
}
