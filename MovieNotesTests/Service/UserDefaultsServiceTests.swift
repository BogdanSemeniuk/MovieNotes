//
//  UserDefaultsServiceTests.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 11.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import XCTest
@testable import MovieNotes

class UserDefaultsServiceTests: XCTestCase {
    
    private var sut: UserDefaultsService!
    
    override func setUpWithError() throws {
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        let coder = Coder.shared
        sut = UserDefaultsService(userDefaults: userDefaults, coder: coder)
    }

    override func tearDownWithError() throws {
    }
    
    func testInitUserDefaultsServiceExistsUserDefaultsService() {
        XCTAssertNotNil(sut)
    }
    
    func testSavedGenresEqualsFetchedGenres() {
        // given
        let genres = [Genre(id: 0, name: "Action"), Genre(id: 1, name: "Comedy")]
        // when
        sut.save(genres)
        let fetchedGenres = sut.fetchGenres()
        // then
        XCTAssert(fetchedGenres.count == 2, "Saved genres count maust be 2")
        XCTAssert(fetchedGenres.contains(where: { $0.id == 0 }), "Genre with id = 0 must be saved")
        XCTAssert(fetchedGenres.contains(where: { $0.id == 1 }), "Genre with id = 0 must be saved")
    }
    
    func testFetchedGenresEqualEmptyArrayIfGenresWerentSavedBefore() {
        // when
        let fetchedGenres = sut.fetchGenres()
        // then
        XCTAssertTrue(fetchedGenres.isEmpty, "Saved genres count maust be 0")
    }
}
