//
//  DataManager.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

final class DataManager {
    private var storage: UserDefaultsStorable
    private var networking: NetworkingService
    
    init(storage: UserDefaultsStorable, networking: NetworkingService) {
        self.storage = storage
        self.networking = networking
    }
}
