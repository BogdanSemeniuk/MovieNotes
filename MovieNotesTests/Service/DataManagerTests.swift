//
//  DataManagerTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
import PromiseKit
@testable import MovieNotes

class DataManagerTests: XCTestCase {

    private var sut: DataManager!
    private var storage: UserDefaultsService!
    
    override func setUpWithError() throws {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        let coder = Coder.shared
        storage = UserDefaultsService(userDefaults: userDefaults, coder: coder)
        sut = DataManager(storage: storage,
                          networking: NetworkingService(session: URLSessionMock(responseType: .error), coder: coder))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataManagerExistAfterInit() {
        XCTAssertNotNil(sut)
    }
    
    func testDataManagerSaveGenresWhenFetchMovies() {
        // given
        let genresExpectation = expectation(description: "Genre expectation")
        var genre: Genre?
        // when
        _ = sut.fetchMovies(page: 1, moviesFilter: .popular).done { [weak self] responseMovies in
            genre = self?.storage.fetchGenre(withId: 0)
            genresExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(genre)
            XCTAssertEqual(genre?.name, "Comedy")
        }
    }
}
