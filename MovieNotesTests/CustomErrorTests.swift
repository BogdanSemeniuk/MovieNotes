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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitErrorNoNil() {
        XCTAssertNotNil(sut)
    }
    
    func testErrorDescriptionIsNotNil() {
        XCTAssertNotNil(sut?.localizedDescription)
    }
}
