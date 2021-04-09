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
        sut = nil
        dataManager = nil
        bindings = nil
    }

    func testMovieListViewModel_whenInitWithDataManager_shouldNotBeNil() throws {
        // when
        sut = MovieListViewModel(dataManager: DataManager(storage: UserDefaultsService(), networking: NetworkingService()))
        // then
        XCTAssertNotNil(sut)
    }
    
    func testMovieListViewModel_whenFetchMovies_viewContrllerWillGetFinishLoadingStates() throws {
        // given
        dataManager = makeDataManager(withResponses: [.moviesData])
        sut = MovieListViewModel(dataManager: dataManager)
        let statusExpectation = expectation(description: "Status expectation")
        sut.statePublisher.sink { state in
            if case .finishedLoading = state {
                statusExpectation.fulfill()
            }
        }.store(in: &bindings)
        // when
        sut.fetchMovies()
        // then
        waitForExpectations(timeout: 1) { (_) in
        }
    }
    
    private func makeDataManager(withResponses responses: [ResponseTypeMock]) -> DataManager {
        let coder = Coder.shared
        let urlSessionMock = URLSessionMock(responses: responses)
        return DataManager(storage: UserDefaultsService(), networking: NetworkingService(session: urlSessionMock, coder: coder))
    }
}
