//
//  UserDefaultsService.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 11.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

final class UserDefaultsService {
    private(set) var userDefaults: UserDefaults
    private(set) var coder: Coder
    
    init(userDefaults: UserDefaults, coder: Coder) {
        self.userDefaults = userDefaults
        self.coder = coder
    }
}
