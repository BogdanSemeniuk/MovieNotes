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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
