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
    var moviesCount: Int { get }
    var moviesPublisher: PublishableSubject<[Movie]> { get }
    func fetchFirstPageOfMovies()
    func fetchNextPageOfMovies()
    func movieCellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType
}

final class MovieListViewModel: MovieListViewModelType {
    var statePublisher: Publishers.Drop<Published<State>.Publisher> { $state.dropFirst() }
    var moviesPublisher = PublishableSubject<[Movie]>([])
    var moviesCount: Int {
        return moviesPublisher.value.count
    }
    @Published private var state = State.loading
    private(set) var page = 1
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func movieCellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType {
        return MovieCellViewModel(movie: moviesPublisher.value[indexPath.row])
    }
    
    func fetchNextPageOfMovies() {
        page += 1
        fetchMovies(page: page)
    }
    
    func fetchFirstPageOfMovies() {
        page = 1
        fetchMovies(page: page)
    }
    
    private func fetchMovies(page: Int) {
        state = .loading
        dataManager.fetchMovies(page: page, moviesFilter: .nowPlaying).done { [weak self] packageOfMovies in
            guard page == 1 else { self?.moviesPublisher.value.append(contentsOf: packageOfMovies.results); return }
            self?.moviesPublisher.value = packageOfMovies.results
        }.catch { [weak self] error in
            self?.state = .error(error)
        }.finally { [weak self] in
            self?.state = .finishedLoading
        }
    }
}
