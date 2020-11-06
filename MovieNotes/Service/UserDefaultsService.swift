//
//  UserDefaultsService.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 11.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

final class UserDefaultsService {
    private var userDefaults: UserDefaults
    private var coder: Coder
    private let genresKey = "genresKey"
    
    init(userDefaults: UserDefaults = .standard, coder: Coder = .shared) {
        self.userDefaults = userDefaults
        self.coder = coder
    }
    
    func save(_ genres: [Genre]) {
        let data = coder.toData(object: genres)
        userDefaults.set(data, forKey: genresKey)
    }
    
    func fetchGenres() -> [Genre] {
        guard let data = userDefaults.data(forKey: genresKey), let genres = coder.map(data: data, type: [Genre].self) else { return [] }
        return genres
    }
}
