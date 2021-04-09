//
//  PublishableSubject.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 09.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Combine

class PublishableSubject<T> {
    var value: T {
        didSet { subject.send(value) }
    }
    var valuePublisher: AnyPublisher<T, Never> {
        subject.eraseToAnyPublisher()
    }
    private let subject = PassthroughSubject<T, Never>()
    
    init(_ value: T) {
        self.value = value
    }
}
