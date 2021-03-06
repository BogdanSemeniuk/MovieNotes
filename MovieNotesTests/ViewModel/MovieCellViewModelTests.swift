//
//  MovieCellViewModelTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 08.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class MovieCellViewModelTests: XCTestCase {
    var sut: MovieCellViewModel!
    let movie = Movie.testMovie
    
    override func setUpWithError() throws {
        sut = MovieCellViewModel(movie: movie)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testMovieCellViewModel_whenInitWithMovie_movieTitleEqualMovieCellViewModelTitle() throws {
        XCTAssertEqual(sut.title, movie.title)
    }
    
    func testMovieCellViewModel_whenInitWithMovie_movieOverviewEqualMovieCellViewModelDescription() throws {
        XCTAssertEqual(sut.description, movie.overview)
    }
    
    func testMovieCellViewModel_whenInitWithMovieAndMovieOverviewIsNil_movieCellViewModelUseDefaultDescription() throws {
        // given
        var movieWithoutOverview = Movie.testMovie
        movieWithoutOverview.overview = nil
        // when
        sut = MovieCellViewModel(movie: movieWithoutOverview)
        // then
        XCTAssertEqual(sut.description, "Description not found")
    }
    
    func testMovieCellViewModel_whenInitWithMovie_movieCellViewModelCreatePosterURL() throws {
        XCTAssertEqual(sut.poster, URL(string: "https://image.tmdb.org/t/p/w342/adfadadfdfhdh.jpg"))
    }
    
    func testMovieCellViewModel_whenInitWithMovieWithoutPosterPath_movieCellViewModelPosterURLIsNil() throws {
        // given
        var movieWithoutPoster = Movie.testMovie
        movieWithoutPoster.posterPath = nil
        // when
        sut = MovieCellViewModel(movie: movieWithoutPoster)
        // then
        XCTAssertNil(sut.poster)
    }
}
