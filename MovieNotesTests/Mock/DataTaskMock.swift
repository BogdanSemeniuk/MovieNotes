//
//  DataTaskMock.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

class MockDataTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let urlError: Error?
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    init(data: Data?, urlResponse: URLResponse?, urlError: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.urlError = urlError
    }
    
    override func resume() {
        completionHandler?(data, urlResponse, urlError)
    }
    
    static func createTask(type: ResponseType) -> MockDataTask {
        switch type {
        case .genreData:
            
            return MockDataTask(data: Data(), urlResponse: nil, urlError: nil)
        case .stringData:
            return MockDataTask(data: "Message".data(using: .utf8), urlResponse: nil, urlError: nil)
        case .mappingError: return MockDataTask(data: nil, urlResponse: nil, urlError: CustomError.mappingError)
        }
    }
}

extension MockDataTask {
    enum ResponseType {
        case mappingError
        case genreData
        case stringData
    }
}
