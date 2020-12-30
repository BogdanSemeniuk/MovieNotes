//
//  MovieDetails.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 30.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

struct MovieDetails {
    var movie: Movie
    var backdrops: [Backdrop]
    var posters: [Poster]
    var trailers: [Video]
    
    init(movie: Movie) {
        self.movie = movie
        self.backdrops = []
        self.posters = []
        self.trailers = []
    }
    
    mutating func add(images: Images) {
        self.backdrops = images.backdrops
        self.posters = images.posters
    }
    
    mutating func add(videos: Videos) {
        self.trailers = videos.results
    }
}
