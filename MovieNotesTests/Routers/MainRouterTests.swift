//
//  MainRouterTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 29.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class MainRouterTests: XCTestCase {
    
    var sut: MainRouter!
    var window: UIWindow?

    override func setUpWithError() throws {
        window = UIWindow()
        sut = MainRouter(window: window!)
    }

    override func tearDownWithError() throws {
        window = nil
        sut = nil
    }
    
    func testMainRouter_whenInitWithWindow_shouldNotBeNil() {
        XCTAssertNotNil(sut.window)
    }
}
