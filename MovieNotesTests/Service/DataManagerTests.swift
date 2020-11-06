//
//  DataManagerTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class DataManagerTests: XCTestCase {

    private var sut: DataManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataManagerExistAfterInit() {
        //when
        sut = DataManager(storage: UserDefaultsService(), networking: NetworkingService())
        //then
        XCTAssertNotNil(sut)
    }
}
