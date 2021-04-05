//
//  MovieCellViewModel.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 05.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation

protocol MovieCellViewModelType {
    var title: String { get }
    var description: String { get }
}

struct MovieCellViewModel: MovieCellViewModelType {
    private var movie: Movie
    var title: String {
        movie.title
    }
    var description: String {
        movie.overview ?? "Description not found"
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
