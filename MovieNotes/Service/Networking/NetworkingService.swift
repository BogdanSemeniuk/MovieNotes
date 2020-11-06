//
//  NetworkingService.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

final class NetworkingService {
    private var session: NetworkSession
    private var coder: Coder
    
    init(session: NetworkSession = URLSession.shared, coder: Coder = .shared) {
        self.session = session
        self.coder = coder
    }
    
    func makeRequst<T: Decodable>(_ urlRequest: URLRequest, castingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: urlRequest, completionHandler: { [weak self] (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let obj = self?.coder.map(data: data, type: castingType) else {
                completion(.failure(CustomError.mappingError));
                return
            }
            completion(.success(obj))
            }).resume()
    }
}
