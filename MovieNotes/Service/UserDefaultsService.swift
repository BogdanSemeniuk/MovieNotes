//
//  UserDefaultsService.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 11.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import PromiseKit

final class UserDefaultsService {
    private var userDefaults: UserDefaults
    private var coder: Coder
    private let genresListKey = "genresListKey"
    
    init(userDefaults: UserDefaults = .standard, coder: Coder = .shared) {
        self.userDefaults = userDefaults
        self.coder = coder
    }
    
    func save(_ genres: GenresList) {
        let data = coder.toData(object: genres)
        userDefaults.set(data, forKey: genresListKey)
    }
    
    func fetchGenre(withId id: Int) -> Genre? {
        guard let data = userDefaults.data(forKey: genresListKey), let genre = coder.map(data: data, type: GenresList.self)?.genres.filter({ $0.id == id }).first else { return nil }
        return genre
    }
    
    func fetchGenresList() throws -> Promise<GenresList> {
        if let data = self.userDefaults.data(forKey: self.genresListKey), let genres = self.coder.map(data: data, type: GenresList.self) {
            return Promise { $0.resolve(genres, nil) }
        } else {
            throw(CustomError.objectIsNotSaved)
        }
    }
}
