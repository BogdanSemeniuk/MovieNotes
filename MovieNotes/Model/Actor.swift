//
//  Actor.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

struct Actor: Decodable {
    var name: String
    var profilePath: String?
    var order: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case order
    }
}
