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
    
    func testMovieListViewModel_whenFetchMovies_subscriberWillGetLoadingState() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData])
        let statusExpectation = expectation(description: "Status expectation")
        sut.statePublisher.sink { state in
            guard case .loading = state else { return }
            statusExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        // then
        waitForExpectations(timeout: 1) { (_) in
        }
    }

    func testMovieListViewModel_whenFetchMovies_subscriberWillGetFinishLoadingState() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData])
        let statusExpectation = expectation(description: "Status expectation")
        sut.statePublisher.sink { state in
            guard case .finishedLoading = state else { return }
            statusExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        // then
        waitForExpectations(timeout: 1) { (_) in
        }
    }

    func testMovieListViewModel_whenFetchMovies_subscriberWillGetErrorState() {
        // given
        configureSUT(withResponses: [.error])
        let statusExpectation = expectation(description: "Status expectation")
        var error: Error?
        sut.statePublisher.sink { state in
            guard case .error(let err) = state else { return }
            error = err
            statusExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(error)
        }
    }

    func testMovieListViewModel_whenFetchMovies_subscriberWillGetMovies() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData])
        let moviesExpectation = expectation(description: "Movies expectation")
        var movies = [Movie]()
        sut.moviesPublisher.valuePublisher.sink { fetchedMovies in
            movies = fetchedMovies
            moviesExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(movies.count, 3)
            XCTAssertEqual(movies.first?.title, "The Croods: A New Age")
        }
    }
    
    func testMovieListViewModel_whenFetchMovies_moviesCountEqualsFetchedMoviesCount() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData])
        let moviesExpectation = expectation(description: "Movies expectation")
        var fetchedMoviesCount = 0
        sut.moviesPublisher.valuePublisher.sink { fetchedMovies in
            fetchedMoviesCount = fetchedMovies.count
            moviesExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.moviesCount, fetchedMoviesCount)
        }
    }
    
    func testMovieListViewModel_fetchMovieCellViewModelForIndexPath() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData])
        let cellViewModelExpectation = expectation(description: "CellViewModel expectation")
        var cellViewModel: MovieCellViewModelType?
        var movie: Movie?
        sut.moviesPublisher.valuePublisher.sink { movies in
            let movieIndexPath = IndexPath(row: movies.count - 1, section: 0)
            movie = movies[movieIndexPath.row]
            cellViewModel = self.sut.movieCellViewModel(for: movieIndexPath)
            cellViewModelExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(cellViewModel)
            XCTAssertEqual(movie?.title, cellViewModel?.title)
        }
    }
    
    func testMovieListViewModel_whenFetchNextPageOfMovies_pageIncreaseByOne() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData])
        // when
        sut.fetchNextPageOfMovies()
        // then
        XCTAssertEqual(sut.page, 2)
    }
    
    func testMovieListViewModel_whenFetchFirstPageOfMoviesCoupleTimes_pageEqualOne() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData, .moviesData])
        // when
        sut.fetchFirstPageOfMovies()
        sut.fetchFirstPageOfMovies()
        // then
        XCTAssertEqual(sut.page, 1)
    }
    
    func testMovieListViewModel_whenFetchFirstPageOfMoviesCoupleTimes_fetchedMoviesShouldOverwritePreviouslyStoredMovies() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData, .moviesData])
        let moviesExpectation = expectation(description: "Movies expectation")
        var responseCount = 0
        var fetchedMoviesCount = 0
        sut.moviesPublisher.valuePublisher.sink { movies in
            responseCount += 1
            fetchedMoviesCount = movies.count
            guard responseCount == 2 else { return }
            moviesExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            self.sut.fetchFirstPageOfMovies()
        }
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(fetchedMoviesCount, 3)
        }
    }
    
    func testMovieListViewModel_whenFetchNextPageOfMovies_fetchedMoviesShouldAppend() {
        // given
        configureSUT(withResponses: [.genresData, .moviesData, .moviesData])
        let moviesExpectation = expectation(description: "Movies expectation")
        var responseCount = 0
        var fetchedMoviesCount = 0
        sut.moviesPublisher.valuePublisher.sink { movies in
            responseCount += 1
            fetchedMoviesCount = movies.count
            guard responseCount == 2 else { return }
            moviesExpectation.fulfill()
        }.store(in: &bindings)
        // when
        sut.fetchFirstPageOfMovies()
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            self.sut.fetchNextPageOfMovies()
        }
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(fetchedMoviesCount, 6)
        }
    }
    
    private func configureSUT(withResponses responses: [ResponseTypeMock], forTestWithName testName: String = #function) {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        let coder = Coder.shared
        let urlSessionMock = URLSessionMock(responses: responses, testName: testName)
        dataManager = DataManager(storage: UserDefaultsService(userDefaults: userDefaults, coder: coder),
                                  networking: NetworkingService(session: urlSessionMock, coder: coder))
        sut = MovieListViewModel(dataManager: dataManager)
    }
}
