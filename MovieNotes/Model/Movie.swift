//
//  Movie.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: Int
    var genres: [Genre]?
    var budget: Int?
    var title: String
    var overview: String?
    var posterPath: String?
    var countries: [Country]?
    var releaseDate: String
    var credits: Credits?
    var voteAverage: Float
    var voteCount: Int
    var genreIds: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case genres
        case budget
        case countries = "production_countries"
        case credits
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
    }
}
