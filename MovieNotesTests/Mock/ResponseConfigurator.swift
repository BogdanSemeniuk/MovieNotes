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
        case .genreData:
            guard let path = Bundle.init(for: ResponseConfigurator.self).path(forResource: "genres", ofType: nil),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't find genre json file") }
            return Promise {
                return $0.fulfill((data: data, response: URLResponseMock()))
            }
        case .stringData:
            return Promise {
                return $0.fulfill((data: "Message".data(using: .utf8)!, response: URLResponseMock()))
            }
        case .error:
            return Promise {
                return $0.reject(MockError.serverError)
            }
        }
        
    }
}

