//
//  MoviesCoordinatorTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 01.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class MoviesCoordinatorTests: XCTestCase {
    var sut: MoviesCoordinator!
    var router: MoviesRouter!
    
    override func setUpWithError() throws {
        router = MoviesRouter(navigationController: UINavigationController())
        sut = MoviesCoordinator(router: router)
    }

    override func tearDownWithError() throws {
        router = nil
        sut = nil
    }
    
    func testMoviesCoordinator_whenShow_firstViewControllerOfRouterNavigationControllerShouldBeMoviesListViewController() {
        // when
        sut.show(animated: true, onDismissed: nil)
        guard let viewController = router.navigationController.viewControllers.first else { XCTFail("Children viewControllers can't be empty"); return }
        // then
        XCTAssertTrue(viewController.isKind(of: MoviesListViewController.self))
    }
    
    func testMoviesCoordinator_whenShow_moviesListViewControllerInitWithCoordinator() {
        // when
        sut.show(animated: true, onDismissed: nil)
        guard let viewController = router.navigationController.viewControllers.first as? MoviesListViewController else { XCTFail("First viewController must be MoviesListViewController"); return }
        // then
        XCTAssertNotNil(viewController.coordinator)
    }
    
    func testMoviesCoordinator_whenShow_moviesListViewControllerInitWithViewModel() {
        // when
        sut.show(animated: true, onDismissed: nil)
        guard let viewController = router.navigationController.viewControllers.first as? MoviesListViewController else { XCTFail("First viewController must be MoviesListViewController"); return }
        // then
        XCTAssertNotNil(viewController.viewModel)
    }
    
    func testMoviesCoordinator_whenShowDetailsOfMovie_movieDetailsViewControllerInitWithViewModelAndCoordinator() {
        // when
        sut.showDetails(of: Movie.testMovie)
        guard let viewController = router.navigationController.viewControllers.first as? MovieDetailsViewController else { XCTFail("First viewController must be MovieDetailsViewController"); return }
        // then
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.coordinator)
    }
}
