//
//  DataManager.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

final class DataManager {
    private var storage: UserDefaultsService
    private var networking: NetworkingService
    
    init(storage: UserDefaultsService, networking: NetworkingService) {
        self.storage = storage
        self.networking = networking
    }
}
