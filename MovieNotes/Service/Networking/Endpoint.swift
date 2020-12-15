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
}

extension Endpoint {
    static let apiKey = "85cfecbf4366c6b833864140f4bc428c"
    
    var request: URLRequest {
        switch self {
        case .ganresList: return URLRequest(url: URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Endpoint.apiKey)&language=en-US")!)
        case let .packageOfMovies(page, moviesFilter):
            return URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(moviesFilter.rawValue)?api_key=\(Endpoint.apiKey)&language=en-US&page=\(page)&region=UA")!)
        }
    }
}

enum MoviesFilter: String {
    case popular
    case upcoming
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
}
