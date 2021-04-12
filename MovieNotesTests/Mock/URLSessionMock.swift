//
//  URLSessionMock.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import PromiseKit
@testable import MovieNotes

final class URLSessionMock: NetworkSession {
    private(set) var requestsCount = 0
    private let responses: [ResponseTypeMock]
    let testName: String
    
    init(responses: [ResponseTypeMock], testName: String) {
        self.responses = responses
        self.testName = testName
    }
    
    public func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        defer {
            requestsCount += 1
        }
        guard requestsCount < responses.count else { fatalError("You set less responses to initialize URLSessionMock then needed for your test. The test name is \(testName). For example a fetchMovies method requires two responses: .genresData and .moviesData. So if you initialize URLSessionMock with one response it'll lead to crash.") }
        return ResponseConfigurator.configure(with: responses[requestsCount])
    }
}
