//
//  Endpoint.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 15.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

enum Endpoint {
    case ganresList
    case packageOfMovies(page: Int, moviesFilter: MoviesFilter)
    case movieDetails(id: Int)
    case movieTrailers(id: Int)
    case movieImages(id: Int)
}

extension Endpoint {
    var request: URLRequest {
        var url: URL!
        switch self {
        case .ganresList:
            url = Helper.baseURL.appendingPathComponent("genre/movie/list").addApiKeyAndLanguage()
        case let .packageOfMovies(page, moviesFilter):
            url = Helper.baseURL.appendingPathComponent("movie/\(moviesFilter.rawValue)").addApiKeyAndLanguage()
                .appending("page", value: String(page)).appending("region", value: "UA")
        case let .movieDetails(id):
            url = Helper.baseURL.appendingPathComponent("movie/\(id)").addApiKeyAndLanguage().appending("append_to_response", value: "credits")
        case let .movieTrailers(id):
            url = Helper.baseURL.appendingPathComponent("movie/\(id)/videos").addApiKeyAndLanguage()
        case let .movieImages(id):
            url = Helper.baseURL.appendingPathComponent("movie/\(id)/images").addApiKeyAndLanguage()
                .appending("include_image_language", value: "null,en")
        }
        return URLRequest(url: url)
    }
}
