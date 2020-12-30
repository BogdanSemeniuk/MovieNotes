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
        return firstly {
            session.dataTask(.promise, with: Endpoint.packageOfMovies(page: page, moviesFilter: moviesFilter).request)
        }.compactMap { [weak self] in
            return self?.coder.map(data: $0.data, type: PackageOfMovies.self)
        }
    }
}
