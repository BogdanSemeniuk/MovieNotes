//
//  MoviesFilterTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 18.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class MoviesFilterTests: XCTestCase {
    func testAllRawValuesContainEveryMovieFilter() {
        for filter in MoviesFilter.allCases {
            guard MoviesFilter.allRawValues.contains(filter.rawValue) else {
                XCTFail("allRawValues must contains raw value of every filter"); return
            }
        }
    }
    
    func testAllRawValuesCountEqualAllCasesCount() {
        XCTAssertEqual(MoviesFilter.allRawValues.count, MoviesFilter.allCases.count)
    }
}
