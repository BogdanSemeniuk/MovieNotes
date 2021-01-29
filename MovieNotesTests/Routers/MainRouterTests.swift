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
        XCTAssertNotNil(sut)
    }
    
    func testMainRouter_whenInitWithWindow_windowInRouterShouldNotBeNil() {
        XCTAssertNotNil(sut.window)
    }
    
    func testMainRouter_whenCallsShow_windowInRouterShouldBeKeyWindow() {
        // when
        sut.show(UIViewController(), animated: false)
        // then
        XCTAssertTrue(sut.window.isKeyWindow)
    }
    
    func testMainRouter_whenCallsShow_viewControllerShouldBeRootViewControllerOfWindow() {
        // given
        let vc = UIViewController()
        // when
        sut.show(vc, animated: false)
        // then
        XCTAssertEqual(sut.window.rootViewController, vc)
    }
}
