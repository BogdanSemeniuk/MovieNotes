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
        guard let path = Bundle.init(for: type(of: self)).path(forResource: "genres", ofType: nil), let data =
            try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't find genre json file") }
        mockDataTask.completionHandler = completionHandler
        return mockDataTask
    }
}
