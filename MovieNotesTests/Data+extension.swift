//
//  Data+extension.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 30.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

extension Data {
    init(bundle: Bundle, fileName: String) {
        guard let path = bundle.path(forResource: fileName, ofType: nil),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't find \(fileName) json file") }
        self = data
    }
}
