//
//  ResponseConfigurator.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 15.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import PromiseKit

class ResponseConfigurator {
    static func configure(with type: ResponseTypeMock) -> Promise<(data: Data, response: URLResponse)> {
        switch type {
        case .genresData:
            return Promise {
                $0.fulfill((data: Data(bundle: Bundle.init(for: ResponseConfigurator.self), fileName: "genres"), response: URLResponseMock()))
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
            return Promise {
                $0.fulfill((data: Data(bundle: Bundle.init(for: ResponseConfigurator.self), fileName: "movies"), response: URLResponseMock()))
            }
        case .movieDetailsData:
            return Promise {
                $0.fulfill((data: Data(bundle: Bundle.init(for: ResponseConfigurator.self), fileName: "movieDetails"), response: URLResponseMock()))
            }
        case .movieImagesData:
            return Promise {
                $0.fulfill((data: Data(bundle: Bundle.init(for: ResponseConfigurator.self), fileName: "images"), response: URLResponseMock()))
            }
        }
    }
}
