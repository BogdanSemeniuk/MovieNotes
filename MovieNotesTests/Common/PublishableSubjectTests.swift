//
//  PublishableSubjectTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 09.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class PublishableSubjectTests: XCTestCase {
    var sut: PublishableSubject<Int>!

    func testPublishableSubject_whenInitWithValue_shouldNotBeNil() throws {
        // when
        sut = PublishableSubject(0)
        // then
        XCTAssertNotNil(sut)
    }
    
    func testPublishableSubject_whenInitWithValue_setValue() {
        // given
        let value = 100
        // when
        sut = PublishableSubject(value)
        // then
        XCTAssertEqual(sut.value, value)
    }
    
    func testPublishableSubject_whenValueChange_sendNewValueToSubscriber() {
        // given
        let value = 100
        var receivedValue: Int?
        let valueExpectation = expectation(description: "Received value expectation")
        sut = PublishableSubject(0)
        // when
        let cancellable = sut.valuePublisher.sink { newValue in
            receivedValue = newValue
            valueExpectation.fulfill()
        }
        sut.value = 100
        // then
        XCTAssertNotNil(cancellable)
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(value, receivedValue)
        }
    }
}
