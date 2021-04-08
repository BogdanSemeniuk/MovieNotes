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
    var statePublisher: Publishers.Drop<Published<State>.Publisher> { get }
    var moviesPublisher: AnyPublisher<[Movie], Never> { get }
    var moviesCount: Int { get }
    func fetchMovies()
    func movieCellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType
}

enum State {
    case loading
    case finishedLoading
    case error(Error)
}

final class MovieListViewModel: MovieListViewModelType {
    var statePublisher: Publishers.Drop<Published<State>.Publisher> { $state.dropFirst() }
    var moviesCount: Int {
        return movies.count
    }
    @Published private var state = State.loading
    var moviesPublisher: AnyPublisher<[Movie], Never> {
        moviesSubject.eraseToAnyPublisher()
    }
    private let moviesSubject = PassthroughSubject<[Movie], Never>()
    private var movies = [Movie]() {
        didSet { moviesSubject.send(movies) }
    }
    
    private var page = 1
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func movieCellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType {
        return MovieCellViewModel(movie: movies[indexPath.row])
    }

    func fetchMovies() {
        state = .loading
        dataManager.fetchMovies(page: page, moviesFilter: .nowPlaying).done { [weak self] packageOfMovies in
            self?.movies = packageOfMovies.results
        }.catch { [weak self] error in
            self?.state = .error(error)
        }.finally { [weak self] in
            self?.state = .finishedLoading
        }
    }
}
