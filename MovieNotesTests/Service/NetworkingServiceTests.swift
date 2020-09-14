//
//  NetworkingServiceTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class NetworkingServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitServiceIsNotNil() {
        let sut = NetworkingService(session: URLSessionMock(mockDataTask: MockDataTask(data: Data(), urlResponse: nil, urlError: nil)), coder: Coder())
        XCTAssertNotNil(sut)
    }
    
    func testAllDependenciesExistAfterInit() {
        let sut = NetworkingService(session: URLSessionMock(mockDataTask: MockDataTask(data: Data(), urlResponse: nil, urlError: nil)), coder: Coder())
        XCTAssertNotNil(sut.coder)
        XCTAssertNotNil(sut.session)
    }
}
