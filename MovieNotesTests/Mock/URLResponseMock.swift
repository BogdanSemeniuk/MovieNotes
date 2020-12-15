//
//  URLResponseMock.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 15.12.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import Foundation

class URLResponseMock: URLResponse {
    init() {
        super.init(url: URL(string: "https://github.com/")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
