//
//  Credits.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 06.11.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

struct Credits: Decodable {
    var cast: [Actor]
    var crew: [Worker]
}
