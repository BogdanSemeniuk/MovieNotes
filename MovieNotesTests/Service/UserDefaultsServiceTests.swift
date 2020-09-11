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
        let coder = Coder()
        sut = UserDefaultsService(userDefaults: userDefaults, coder: coder)
    }

    override func tearDownWithError() throws {
    }
    
    func testInitUserDefaultsServiceExistsUserDefaultsService() {
        XCTAssertNotNil(sut)
    }
    
    func testInitUserDefaultsServiceExistsUserDefaultsInService() {
        XCTAssertNotNil(sut.userDefaults)
    }
    
    func testInitUserDefaultsServiceExistsCoderInService() {
        XCTAssertNotNil(sut.coder)
    }
}
