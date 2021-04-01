//
//  MoviesListViewController.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit
import Combine

protocol MoviesListCoordinatorDelegate: class {
    
}

final class MoviesListViewController: UIViewController, Storyboarded {
    weak var coordinator: MoviesListCoordinatorDelegate?
    var viewModel: MovieListViewModelType?
    private var bindings = Set<AnyCancellable?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        let stateBinding = viewModel?.statePublisher.sink(receiveValue: { state in
            guard let state = state else { return }
            switch state {
            case .loading: print("Loading")
            case .finishedLoading: print("finishedLoading")
            case .error: print("error")
            }
        })
        bindings.insert(stateBinding)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        viewModel?.fetchMovies()
    }
}
