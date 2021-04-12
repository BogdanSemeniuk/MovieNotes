//
//  MovieListViewModelTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 09.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes
import Combine

class MovieListViewModelTests: XCTestCase {
    var sut: MovieListViewModel!
    var dataManager: DataManager!
    var bindings: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        bindings = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        dataManager = nil
        sut = nil
        bindings = nil
    }
    
    func testMovieListViewModel_whenFetchMovies_subscriberWillGetLoadingState() throws {
        // given
        configureSUT(withResponses: [.genresData, .moviesData], forTestWithName: #function)
        let statusExpectation = expectation(description: "Status expectation")
        sut.statePublisher.sink { state in
            guard case .loading = state else { return }
            statusExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchMovies()
        // then
        waitForExpectations(timeout: 1) { (_) in
        }
    }

    func testMovieListViewModel_whenFetchMovies_subscriberWillGetFinishLoadingState() throws {
        // given
        configureSUT(withResponses: [.genresData, .moviesData], forTestWithName: #function)
        let statusExpectation = expectation(description: "Status expectation")
        sut.statePublisher.sink { state in
            guard case .finishedLoading = state else { return }
            statusExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchMovies()
        // then
        waitForExpectations(timeout: 1) { (_) in
        }
    }

    func testMovieListViewModel_whenFetchMovies_subscriberWillGetErrorState() throws {
        // given
        configureSUT(withResponses: [.error], forTestWithName: #function)
        let statusExpectation = expectation(description: "Status expectation")
        var error: Error?
        sut.statePublisher.sink { state in
            guard case .error(let err) = state else { return }
            error = err
            statusExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchMovies()
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(error)
        }
    }

    func testMovieListViewModel_whenFetchMovies_subscriberWillGetMovies() throws {
        // given
        configureSUT(withResponses: [.genresData, .moviesData], forTestWithName: #function)
        let moviesExpectation = expectation(description: "Movies expectation")
        var movies = [Movie]()
        sut.moviesPublisher.valuePublisher.sink { fetchedMovies in
            movies = fetchedMovies
            moviesExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchMovies()
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(movies.count, 3)
            XCTAssertEqual(movies.first?.title, "The Croods: A New Age")
        }
    }
    
    func testMovieListViewModel_whenFetchMovies_moviesCountEqualsFetchedMoviesCount() throws {
        // given
        configureSUT(withResponses: [.genresData, .moviesData], forTestWithName: #function)
        let moviesExpectation = expectation(description: "Movies expectation")
        var fetchedMoviesCount = 0
        sut.moviesPublisher.valuePublisher.sink { fetchedMovies in
            fetchedMoviesCount = fetchedMovies.count
            moviesExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchMovies()
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.moviesCount, fetchedMoviesCount)
        }
    }
    
    private func configureSUT(withResponses responses: [ResponseTypeMock], forTestWithName testName: String) {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        let coder = Coder.shared
        let urlSessionMock = URLSessionMock(responses: responses, testName: testName)
        dataManager = DataManager(storage: UserDefaultsService(userDefaults: userDefaults, coder: coder),
                                  networking: NetworkingService(session: urlSessionMock, coder: coder))
        sut = MovieListViewModel(dataManager: dataManager)
    }
}
