//
//  MovieListViewModel.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 01.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation
import Combine
import PromiseKit

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
    private var page = 1
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func fetchMovies() {
        state = .loading
        dataManager.fetchMovies(page: page, moviesFilter: .nowPlaying).done { [weak self] packageOfMovies in
            print(packageOfMovies.results.count)
        }.catch { [weak self] error in
            self?.state = .error(error)
        }.finally { [weak self] in
            self?.state = .finishedLoading
        }
    }
}
