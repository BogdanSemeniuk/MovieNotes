//
//  Images.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 30.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

struct Images: Decodable {
    var backdrops: [Backdrop]
    var posters: [Poster]
}

struct Backdrop: Decodable {
    var filePath: String
    var height: Int
    var width: Int
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case height
        case width
    }
}

struct Poster: Decodable {
    var filePath: String
    var height: Int
    var width: Int
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case height
        case width
    }
}
