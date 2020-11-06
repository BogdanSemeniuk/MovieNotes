//
//  Worker.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

struct Worker: Decodable {
    var name: String
    var job: String
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case job
        case profilePath = "profile_path"
    }
}
