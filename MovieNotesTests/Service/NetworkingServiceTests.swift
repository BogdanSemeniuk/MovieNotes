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
    func testNetworkingService_whenInit_shouldNotBeNil() {
        let sut = NetworkingService(session: URLSessionMock(responses: [.genresData]), coder: Coder.shared)
        XCTAssertNotNil(sut)
    }
    
    func testNetworkingService_whenFetchGenresWithSuccessResult_shouldFetchGenres() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responses: [.genresData]), coder: Coder.shared)
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
    
    func testNetworkingService_whenFetchGenresWithFailureResult_shouldGetError() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responses: [.error]), coder: Coder.shared)
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
    
    func testNetworkingService_whenFetchGenresAndGetWrongTypeData_shouldGetError() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responses: [.stringData]), coder: Coder.shared)
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
    
    func testNetworkingService_whenFetchMoviesWithSuccessResult_shouldFetchMovies() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responses: [.moviesData]), coder: Coder.shared)
        let moviesExpectation = expectation(description: "Movies expectation")
        var packageOfMovies: PackageOfMovies?
        // when
        _ = sut.fetchMovies(page: 1, moviesFilter: .nowPlaying).done { (responseMovies) in
            packageOfMovies = responseMovies
            moviesExpectation.fulfill()
        }
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(packageOfMovies)
            XCTAssertEqual(packageOfMovies?.results.count, 3)
        }
    }
    
    func testNetworkingService_whenFetchMovieDetailsWithSuccessResult_shouldFetchMovieDetails() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responses: [.movieDetailsData]), coder: Coder.shared)
        let movieDetailsExpectation = expectation(description: "Movie details expectation")
        var movieDetails: Movie?
        // when
        _ = sut.fetchMovieDetails(id: 1).done({ (responseMovieDetails) in
            movieDetails = responseMovieDetails
            movieDetailsExpectation.fulfill()
        })
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(movieDetails)
            XCTAssertEqual(movieDetails?.id, 652004)
            XCTAssertEqual(movieDetails?.title, "The Wolf of Snow Hollow")
        }
    }
    
    func testNetworkingService_whenFetchImagesWithSuccessResult_shouldFetchImages() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responses: [.movieImagesData]), coder: Coder.shared)
        let movieImagesExpectation = expectation(description: "Movie images expectation")
        var images: Images?
        // when
        _ = sut.fetchImages(id: 1).done({ responseImages in
            images = responseImages
            movieImagesExpectation.fulfill()
        })
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(images)
            XCTAssertEqual(images?.backdrops.first?.filePath, "/gbdiI8tzptuOcGp4anJeZAiUzA1.jpg")
            XCTAssertEqual(images?.posters.first?.filePath, "/nXeTSXR5ryFwxrlpmD9hhXJTAuc.jpg")
        }
    }
    
    func testNetworkingService_whenFetchTrailersWithSuccessResult_shouldFetchTrailers() {
        // given
        let sut = NetworkingService(session: URLSessionMock(responses: [.movieTrailersData]), coder: Coder.shared)
        let movieTrailersExpectation = expectation(description: "Movie trailers expectation")
        var trailers: Videos?
        // when
        _ = sut.fetchTrailers(id: 1).done({ responseTrailers in
            trailers = responseTrailers
            movieTrailersExpectation.fulfill()
        })
        // then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertNotNil(trailers)
            XCTAssertEqual(trailers?.results.first?.name, "THE WOLF OF SNOW HOLLOW Official Trailer (2020)")
        }
    }
}
