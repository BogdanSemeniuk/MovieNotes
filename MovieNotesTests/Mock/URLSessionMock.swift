//
//  URLSessionMock.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation
import PromiseKit
@testable import MovieNotes


final class URLSessionMock: NetworkSession {
    private let responseType: ResponseTypeMock
    
    init(responseType: ResponseTypeMock) {
        self.responseType = responseType
    }
    
    public func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        return ResponseConfigurator.configure(with: responseType)
    }
}
