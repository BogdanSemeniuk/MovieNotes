//
//  CoderTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 11.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class CoderTests: XCTestCase {

    private var sut: Coder?
    
    override func setUpWithError() throws {
        sut = Coder.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitCoderIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testCreateDataFromObject() {
        // given
        let genre = Genre(id: 0, name: "Action")
        // when
        let data = sut?.toData(object: genre)
        // then
        XCTAssertNotNil(data)
    }
    
    func testMapObjectFromData() {
        // given
        let genre = Genre(id: 0, name: "Action")
        guard let data = sut?.toData(object: genre) else { XCTFail("Can't create data"); return }
        // when
        guard let object = sut?.map(data: data, type: Genre.self) else { XCTFail("Can't map Genre from data"); return }
        // then
        XCTAssertEqual(genre.id, object.id, "Ids must be equal")
        XCTAssertEqual(genre.name, object.name, "Names must be equal")
    }
    
    func testMapArrayOfObjects() {
        // given
        let genres = [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy")]
        guard let data = sut?.toData(object: genres) else { XCTFail("Can't create data"); return }
        // when
        guard let objects = sut?.map(data: data, type: [Genre].self) else { XCTFail("Can't map Genre from data"); return }
        // then
        XCTAssertEqual(objects.count, 2, "Objects count must be two")
    }
    
    func testMapObjectFailIfWrongTypeExpected() {
        // given
        let genre = Genre(id: 0, name: "Action")
        guard let data = sut?.toData(object: genre) else { XCTFail("Can't create data"); return }
        // when
        let object = sut?.map(data: data, type: String.self)
        // then
        XCTAssertNil(object, "Object maust be nil")
    }
}
