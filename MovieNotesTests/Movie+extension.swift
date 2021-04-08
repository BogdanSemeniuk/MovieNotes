//
//  Movie+extension.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 08.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation
@testable import MovieNotes

extension Movie {
    static let testMovie = Movie(id: 1,
                                 genres: [Genre(id: 1, name: "Action")],
                                 budget: 1000, title: "Batmen",
                                 overview: "Batman is a superhero who appears in American comic books published by DC Comics.",
                                 posterPath: "/adfadadfdfhdh.jpg",
                                 countries: [Country(name: "USA")],
                                 releaseDate: "June 23, 1989", credits: nil,
                                 voteAverage: 9.0, voteCount: 123, genreIds: [1])
}
