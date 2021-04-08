//
//  ReuseIdentifiable.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 08.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
