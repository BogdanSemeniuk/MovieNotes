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
    
    func testFetchGenres() {
        // given
        let sut = NetworkingService(session: URLSessionMock(mockDataTask: MockDataTask.createTask(responseType: .genreData)), coder: Coder())
        let genresExpectation = expectation(description: "Genres expectation")
        var genres: [Genre]?
        
        // when
        sut.makeRequst(URLRequest(url: URL(string: "https://www.test")!), castingType: [Genre].self, completion: { response in
            switch response {
            case .success(let responseGenres):
                genres = responseGenres
                genresExpectation.fulfill()
            default: break
            }
        })
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(genres)
            XCTAssertEqual(genres?.count, 2)
        }
    }
    
    func testGetErrorWhenMakeRequest() {
        // given
        let sut = NetworkingService(session: URLSessionMock(mockDataTask: MockDataTask.createTask(responseType: .mappingError)), coder: Coder())
        let errorExpectation = expectation(description: "Error expectation")
        var error: Error?
        // when
        sut.makeRequst(URLRequest(url: URL(string: "https://www.test")!), castingType: [Genre].self, completion: { response in
            switch response {
            case .failure(let responseError):
                error = responseError
                errorExpectation.fulfill()
            default: break
            }
        })
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(error)
        }
    }
    
    func testGetErrorWhenMakeRequestAndSetWrongCastingType() {
        // given
        let sut = NetworkingService(session: URLSessionMock(mockDataTask: MockDataTask.createTask(responseType: .genreData)), coder: Coder())
        let errorExpectation = expectation(description: "Mapping error expectation")
        var error: Error?
        // when
        sut.makeRequst(URLRequest(url: URL(string: "https://www.test")!), castingType: String.self, completion: { response in
            switch response {
            case .failure(let responseError):
                error = responseError
                errorExpectation.fulfill()
            default: break
            }
        })
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(error)
        }
    }
}