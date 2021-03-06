//
//  NetworkingService.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import PromiseKit

final class NetworkingService {
    private var session: NetworkSession
    private var coder: Coder
    
    init(session: NetworkSession = URLSession.shared, coder: Coder = .shared) {
        self.session = session
        self.coder = coder
    }
    
    func fetchGanres() -> Promise<GenresList> {
        return firstly {
            session.dataTask(.promise, with: Endpoint.ganresList.request)
        }.compactMap { [weak self] in
            return self?.coder.map(data: $0.data, type: GenresList.self)
        }
    }
    
    func fetchMovies(page: Int, moviesFilter: MoviesFilter) -> Promise<PackageOfMovies> {
        let request = Endpoint.packageOfMovies(page: page, moviesFilter: moviesFilter).request
        URLCache.shared.removeCachedResponse(for: request)
        return firstly {
            session.dataTask(.promise, with: request)
        }.compactMap { [weak self] in
            return self?.coder.map(data: $0.data, type: PackageOfMovies.self)
        }
    }
    
    func fetchMovieDetails(id: Int) -> Promise<Movie> {
        return firstly {
            session.dataTask(.promise, with: Endpoint.movieDetails(id: id).request)
        }.compactMap { [weak self] in
            return self?.coder.map(data: $0.data, type: Movie.self)
        }
    }
    
    func fetchImages(id: Int) -> Promise<Images> {
        return firstly {
            session.dataTask(.promise, with: Endpoint.movieImages(id: id).request)
        }.compactMap { [weak self] in
            return self?.coder.map(data: $0.data, type: Images.self)
        }
    }
    
    func fetchTrailers(id: Int) -> Promise<Videos> {
        return firstly {
            session.dataTask(.promise, with: Endpoint.movieTrailers(id: id).request)
        }.compactMap { [weak self] in
            return self?.coder.map(data: $0.data, type: Videos.self)
        }
    }
}
