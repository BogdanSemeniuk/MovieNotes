//
//  URLSessionMock.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation
@testable import MovieNotes

final class URLSessionMock: NetworkSession {
    
    private let mockDataTask: MockDataTask
    
    init(mockDataTask: MockDataTask) {
        self.mockDataTask = mockDataTask
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        mockDataTask.completionHandler = completionHandler
        return mockDataTask
    }
}
