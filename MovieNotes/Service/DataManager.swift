//
//  DataManager.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import PromiseKit

final class DataManager {
    private var storage: UserDefaultsService
    private var networking: NetworkingService
    
    init(storage: UserDefaultsService, networking: NetworkingService) {
        self.storage = storage
        self.networking = networking
    }
    
    func fetchMovies(page: Int, moviesFilter: MoviesFilter) -> Promise<PackageOfMovies> {
        return firstly {
            self.fetchAndSaveGenresList()
        }.then { _ in
            self.networking.fetchMovies(page: page, moviesFilter: moviesFilter)
        }
    }
    
    private func fetchAndSaveGenresList() -> Promise<GenresList> {
        return firstly {
            try storage.fetchGenresList()
        }.recover { _ in
            self.networking.fetchGanres()
        }.get { genreList in
            guard (try? self.storage.fetchGenresList()) == nil else { return }
            self.storage.save(genreList)
        }
    }
}
