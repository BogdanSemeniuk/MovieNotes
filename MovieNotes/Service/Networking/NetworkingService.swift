//
//  NetworkingService.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 14.09.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

final class NetworkingService {
    private(set) var session: NetworkSession
    private(set) var coder: Coder
    
    init(session: NetworkSession, coder: Coder) {
        self.session = session
        self.coder = coder
    }
}
