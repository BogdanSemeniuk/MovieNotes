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
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .mappingError: return "JSON mapping failed"
        }
    }
}
