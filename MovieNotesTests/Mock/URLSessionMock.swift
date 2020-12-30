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
    var requestsCount = 0
    private let responses: [ResponseTypeMock]
    
    init(responses: [ResponseTypeMock]) {
        self.responses = responses
    }
    
    public func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        defer {
            requestsCount += 1
        }
        return ResponseConfigurator.configure(with: responses[requestsCount])
    }
}

