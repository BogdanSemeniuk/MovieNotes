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
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataManagerExistAfterInit() {
        configureSUT(withResponses: [.error])
        XCTAssertNotNil(sut)
    }
    
    func testDataManagerSaveGenresWhenSuccessInFetchingMovies() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData])
        let genresExpectation = expectation(description: "Genre expectation")
        var genre: Genre?
        var package: PackageOfMovies?
        // when
        _ = sut.fetchMovies(page: 1, moviesFilter: .popular).done { [weak self] responseMovies in
            package = responseMovies
            genre = self?.storage.fetchGenre(withId: 0)
            genresExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(package)
            XCTAssertEqual(package?.results.first?.id, 529203)
            XCTAssertNotNil(genre)
            XCTAssertEqual(genre?.name, "Comedy")
        }
    }
    
    private func configureSUT(withResponses responses: [ResponseTypeMock]) {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        let coder = Coder.shared
        storage = UserDefaultsService(userDefaults: userDefaults, coder: coder)
        sut = DataManager(storage: storage,
                          networking: NetworkingService(session: URLSessionMock(responses: responses), coder: coder))
    }
}
