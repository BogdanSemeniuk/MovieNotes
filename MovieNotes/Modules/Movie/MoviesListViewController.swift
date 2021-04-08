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
    @IBOutlet private weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel?.fetchMovies()
    }
    
    private func setupBindings() {
        let stateBinding = viewModel?.statePublisher.sink(receiveValue: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading: self.add(self.loadingViewController, container: self.view)
            case .finishedLoading: self.loadingViewController.remove()
            case .error(let error):
                self.loadingViewController.remove()
                self.present(UIAlertController.make(withMessage: error.localizedDescription), animated: true)
            }
        })
        let moviesBinding = viewModel?.moviesPublisher.sink{ [weak self] _ in
            self?.moviesTableView.reloadData()
        }
        bindings.insert(stateBinding)
        bindings.insert(moviesBinding)
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.moviesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        cell.viewModel = viewModel?.movieCellViewModel(for: indexPath)
        return cell
    }
}
