//
//  NetworkingServiceTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
import PromiseKit
@testable import MovieNotes

class NetworkingServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitServiceIsNotNil() {
        let sut = NetworkingService(session: URLSessionMock(responseType: .genresData), coder: Coder.shared)
        XCTAssertNotNil(sut)
    }
    
    func testFetchGenres() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responseType: .genresData), coder: Coder.shared)
        let genresExpectation = expectation(description: "Genres expectation")
        var genresList: GenresList?
        // when
        _ = sut.fetchGanres().done { (responseGenres) in
            genresList = responseGenres
            genresExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(genresList)
            XCTAssertEqual(genresList?.genres.count, 2)
        }
    }
    
    func testGetErrorWhenMakeRequest() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responseType: .error), coder: Coder.shared)
        let errorExpectation = expectation(description: "Error expectation")
        var error: Error?
        // when
        _ = sut.fetchGanres().catch { (responseError) in
            error = responseError
            errorExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(error)
        }
    }
    
    func testGetErrorWhenMakeRequestAndFetchWrongTypeOfResponse() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responseType: .stringData), coder: Coder.shared)
        let errorExpectation = expectation(description: "Mapping error expectation")
        var error: Error?
        // when
        _ = sut.fetchGanres().catch { (responseError) in
            error = responseError
            errorExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchMovies() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responseType: .moviesData), coder: Coder.shared)
        let moviesExpectation = expectation(description: "Movies expectation")
        var packageOfMovies: PackageOfMovies?
        // when
        _ = sut.fetchMovies(page: 1, moviesFilter: .nowPlaying).done { (responseMovies) in
            packageOfMovies = responseMovies
            moviesExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (responseMovies) in
            XCTAssertNotNil(packageOfMovies)
            XCTAssertEqual(packageOfMovies?.results.count, 3)
        }
    }
}
