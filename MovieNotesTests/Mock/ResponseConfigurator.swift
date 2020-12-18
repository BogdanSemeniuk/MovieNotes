//
//  ResponseConfigurator.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 15.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation
import PromiseKit

class ResponseConfigurator {
    static func configure(with type: ResponseTypeMock) -> Promise<(data: Data, response: URLResponse)> {
        switch type {
        case .genresData:
            guard let path = Bundle.init(for: ResponseConfigurator.self).path(forResource: "genres", ofType: nil),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't find genre json file") }
            return Promise {
                $0.fulfill((data: data, response: URLResponseMock()))
            }
        case .stringData:
            return Promise {
                $0.fulfill((data: "Message".data(using: .utf8)!, response: URLResponseMock()))
            }
        case .error:
            return Promise {
                $0.reject(MockError.serverError)
            }
        case .moviesData:
            guard let path = Bundle.init(for: ResponseConfigurator.self).path(forResource: "movies", ofType: nil),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't find genre json file") }
            return Promise {
                $0.fulfill((data: data, response: URLResponseMock()))
            }
        }
    }
}

