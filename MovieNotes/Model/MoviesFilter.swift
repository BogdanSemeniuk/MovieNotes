//
//  MoviesFilter.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 18.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

enum MoviesFilter: String, CaseIterable {
    case popular
    case upcoming
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
    
    static var allRawValues: [String] {
        return MoviesFilter.allCases.map({ $0.rawValue })
    }
}
