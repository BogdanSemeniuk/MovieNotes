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
    private var urlSessionMock: URLSessionMock!
    
    func testDataManager_whenInit_shouldNotBeNil() {
        configureSUT(withResponses: [.error])
        XCTAssertNotNil(sut)
    }
    
    func testDataManager_whenFetchMoviesWithSuccessResult_genresShouldBeSavedToStorageAndPackageOfMoviesShouldBeFetched() {
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
    
    func testDataManager_whenFetchMoviesWithFailureResultButFetchGenresWithSuccessResult_genresShouldBeSavedToStorage() {
        // given
        configureSUT(withResponses: [.genresData, .error])
        let genresExpectation = expectation(description: "Genre expectation")
        var genre: Genre?
        // when
        _ = sut.fetchMovies(page: 1, moviesFilter: .popular).catch { [weak self] _ in
            genre = self?.storage.fetchGenre(withId: 0)
            genresExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(genre)
            XCTAssertEqual(genre?.name, "Comedy")
        }
    }
    
    func testDataManager_whenFetchMoviesAndGenresWereStoredBefore_shouldFetchGenresFromStorageNotFromNetwork() {
        // given
        configureSUT(withResponses: [.moviesData])
        let genresList = GenresList(genres: [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy")])
        let genresExpectation = expectation(description: "Genre expectation")
        var genre: Genre?
        // when
        storage.save(genresList)
        _ = sut.fetchMovies(page: 1, moviesFilter: .popular).done { [weak self] _ in
            genre = self?.storage.fetchGenre(withId: 0)
            genresExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(genre)
            XCTAssertEqual(genre?.name, "Action")
        }
    }
    
    func testDataManager_whenFetchingMoviesAndFetchGenresWithFailureResult_shouldGetError() {
        // given
        configureSUT(withResponses: [.error, .moviesData])
        let errorExpectation = expectation(description: "Error expectation")
        var error: Error?
        // when
        _ = sut.fetchMovies(page: 1, moviesFilter: .popular).catch { errorResponse in
            error = errorResponse
            errorExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(error)
            XCTAssertEqual(error as? MockError, .serverError)
        }
    }
    
    func testDataManager_whenFetchingMoviesAndGenresWereStoredBefore_networkRequestsCountShouldBeEqualOne() {
        // given
        configureSUT(withResponses: [.moviesData])
        let genresList = GenresList(genres: [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy")])
        let requestsCountExpectation = expectation(description: "Request count expectation")
        // when
        storage.save(genresList)
        _ = sut.fetchMovies(page: 1, moviesFilter: .popular).done { _ in
            requestsCountExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertEqual(self.urlSessionMock.requestsCount, 1)
        }
    }
    
    private func configureSUT(withResponses responses: [ResponseTypeMock]) {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        let coder = Coder.shared
        storage = UserDefaultsService(userDefaults: userDefaults, coder: coder)
        urlSessionMock = URLSessionMock(responses: responses)
        sut = DataManager(storage: storage,
                          networking: NetworkingService(session: urlSessionMock, coder: coder))
    }
}
