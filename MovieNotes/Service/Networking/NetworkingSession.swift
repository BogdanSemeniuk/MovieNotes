//
//  NetworkingSession.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkSession {
    func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)>
}

extension URLSession: NetworkSession {}
