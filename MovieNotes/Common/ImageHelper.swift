//
//  ImageHelper.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 08.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation

struct ImageHelper {
    static func fullPath(for filePath: String, withSize size: ImageSize) -> URL {
        return Helper.imageBaseURL.appendingPathComponent(size.rawValue).appendingPathComponent(filePath)
    }
    
    enum ImageSize: String {
        case small = "w185"
        case medium = "w342"
        case large = "w500"
    }
}
