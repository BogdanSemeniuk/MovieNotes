//
//  CustomError.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case mappingError
    case objectIsNotSaved
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .objectIsNotSaved: return "Storage doesn't contain this object"
        case .mappingError: return "JSON mapping failed"
        }
    }
}
