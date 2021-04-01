//
//  MovieListViewModel.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 01.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation
import Combine

protocol MovieListViewModelType {
    func fetchMovies()
    var statePublisher: Published<State?>.Publisher { get }
}

enum State {
    case loading
    case finishedLoading
    case error(Error)
}

final class MovieListViewModel: MovieListViewModelType {
    var statePublisher:  Published<State?>.Publisher { $state }
    @Published private var state: State!
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func fetchMovies() {
        state = .loading
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.state = .finishedLoading
        }
    }
}
