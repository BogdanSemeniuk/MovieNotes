//
//  MovieDetailsTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 30.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class MovieDetailsTests: XCTestCase {
    private var sut: MovieDetails!
    private var decoder = Coder.shared
    private var images: Images!
    var videos: Videos!
    
    override func setUpWithError() throws {
        guard let movie = decoder.map(data: Data(bundle: Bundle.init(for: MovieDetailsTests.self), fileName: "movieDetails"), type: Movie.self) else { fatalError("Can't create movie details ") }
        images = decoder.map(data: Data(bundle: Bundle.init(for: MovieDetailsTests.self), fileName: "images"), type: Images.self)
        videos = decoder.map(data: Data(bundle: Bundle.init(for: MovieDetailsTests.self), fileName: "trailers"), type: Videos.self)
        sut = MovieDetails(movie: movie)
    }
    
    func testInitWithMovieIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInitWithMovieBackdropsPostersTrailersAreEmptyArrays() {
        XCTAssertNotNil(sut.movie)
        XCTAssertTrue(sut.backdrops.isEmpty)
        XCTAssertTrue(sut.posters.isEmpty)
        XCTAssertTrue(sut.trailers.isEmpty)
    }
    
    func testAddImagesSetBeckdropsAndPosters() {
        // when
        sut.add(images: images)
        // then
        XCTAssertEqual(sut.posters.count, images.posters.count)
        XCTAssertEqual(sut.backdrops.count, images.backdrops.count)
    }
    
    func testAddVideosSetTrailers() {
        // when
        sut.add(videos: videos)
        // then
        XCTAssertEqual(sut.trailers.count, videos.results.count)
    }
}
