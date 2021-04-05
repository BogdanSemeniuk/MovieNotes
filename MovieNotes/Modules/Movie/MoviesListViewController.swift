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
    private lazy var loadingViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        let stateBinding = viewModel?.statePublisher.sink(receiveValue: { [weak self] state in
            guard let state = state, let self = self else { return }
            switch state {
            case .loading: self.add(self.loadingViewController, container: self.view)
            case .finishedLoading: self.loadingViewController.remove()
            case .error(let error):
                self.loadingViewController.remove()
                self.present(UIAlertController.make(withMessage: error.localizedDescription), animated: true)
            }
        })
        bindings.insert(stateBinding)
    }
}
