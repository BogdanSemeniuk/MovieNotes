//
//  Videos.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 30.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

struct Videos: Decodable {
    var results: [Video]
}

struct Video: Decodable {
    var name: String
    var key: String
}
