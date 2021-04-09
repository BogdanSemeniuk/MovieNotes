//
//  ReuseIdentifiableTest.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 09.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class ReuseIdentifiableTest: XCTestCase {
    func testDefaultReuseIdentifierEqualClassNameDescription() throws {
        XCTAssertEqual(MovieCell.reuseIdentifier, String(describing: MovieCell.self))
    }
}
