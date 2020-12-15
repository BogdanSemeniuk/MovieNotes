//
//  UserDefaultsServiceTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 11.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class UserDefaultsServiceTests: XCTestCase {
    
    private var sut: UserDefaultsService!
    
    override func setUpWithError() throws {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        let coder = Coder.shared
        sut = UserDefaultsService(userDefaults: userDefaults, coder: coder)
    }

    override func tearDownWithError() throws {
    }
    
    func testInitUserDefaultsServiceExistsUserDefaultsService() {
        XCTAssertNotNil(sut)
    }
    
    func testSavedGenresEqualsFetchedGenres() {
        // given
        let genres = [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy")]
        // when
        sut.save(genres)
        let fetchedGenre = sut.fetchGenre(withId: 1)
        // then
        XCTAssert(fetchedGenre?.id == 1, "Genre with id = 1 must be saved")
        XCTAssert(fetchedGenre?.name == "Comedy", "Genre with name = Comedy must be saved")
    }
    
    func testFetchGenresWhenGenresWereSavedBefore() {
        // given
        let genres = [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy")]
        let genresExpectation = expectation(description: "Genres expectation")
        var storedGenres: [Genre]?
        // when
        sut.save(genres)
        sut.fetchGenres(completion: { (responseGenres, _) in
            storedGenres = responseGenres
            genresExpectation.fulfill()
        })
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(storedGenres)
            XCTAssertEqual(storedGenres?.count, 2)
        }
    }
    
    func testGetErrorWhenFetchGenresButGenresWereNotSavedBefore() {
        // given
        let errorExpectation = expectation(description: "Error expectation")
        var error: Error?
        // when
        sut.fetchGenres(completion: { (_, responseError) in
            error = responseError
            errorExpectation.fulfill()
        })
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchedGenresEqualEmptyArrayIfGenresWerentSavedBefore() {
        // when
        let fetchedGenre = sut.fetchGenre(withId: 1)
        // then
        XCTAssertNil(fetchedGenre, "Fetched genre must be nil")
    }
}
