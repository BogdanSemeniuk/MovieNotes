//
//  MockError.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 15.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

enum MockError: Error {
    case serverError
}

extension MockError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError: return "Some server error"
        }
    }
}
