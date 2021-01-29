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

    override func setUpWithError() throws {
        let mainRouter = MainRouter(window: UIWindow())
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
}
