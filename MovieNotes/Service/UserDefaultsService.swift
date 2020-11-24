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
    
    func fetchGenre(withId id: Int) -> Genre? {
        guard let data = userDefaults.data(forKey: genresKey), let genre = coder.map(data: data, type: [Genre].self)?.filter({ $0.id == id }).first else { return nil }
        return genre
    }
}
