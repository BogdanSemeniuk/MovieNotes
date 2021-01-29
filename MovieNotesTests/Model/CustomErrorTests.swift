//
//  CustomErrorTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class CustomErrorTests: XCTestCase {

    var sut: CustomError?
    
    override func setUpWithError() throws {
        sut = CustomError.mappingError
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testCustomError_whenInit_shouldNotBeNil() {
        XCTAssertNotNil(sut)
    }
    
    func testCustomError_whenInit_ErrorDescriptionShouldNotBeNil() {
        XCTAssertNotNil(sut?.localizedDescription)
    }
}
