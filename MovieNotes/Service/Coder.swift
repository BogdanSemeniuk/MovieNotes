//
//  Coder.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 11.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

final class Coder {
    private var decoder = JSONDecoder()
    private var encoder = JSONEncoder()
    
    func toData<T: Encodable>(object: T) -> Data? {
        return try? encoder.encode(object)
    }
    
    func map<T: Decodable>(data: Data, type: T.Type) -> T? {
         return try? decoder.decode(type, from: data)
    }
}
