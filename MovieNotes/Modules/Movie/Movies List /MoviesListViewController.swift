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
    func showDetails(of movie: Movie)
}

final class MoviesListViewController: UIViewController, Storyboarded {
    weak var coordinator: MoviesListCoordinatorDelegate?
    var viewModel: MovieListViewModelType!
    
    private var bindings = Set<AnyCancellable?>()
    private lazy var loadingViewController = LoadingViewController()
    @IBOutlet private weak var moviesTableView: RefreshableTableView!
    private var didScrollToBottom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel?.fetchFirstPageOfMovies()
        moviesTableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
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
        let moviesBinding = viewModel?.moviesPublisher.valuePublisher.sink{ [weak self] _ in
            self?.moviesTableView.reloadData()
            self?.didScrollToBottom = false
        }
        bindings.insert(stateBinding)
        bindings.insert(moviesBinding)
    }
    
    @objc private func refresh(_ sender: Any) {
        moviesTableView.refreshControl?.endRefreshing()
        viewModel?.fetchFirstPageOfMovies()
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

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.showDetails(of: viewModel.movie(for: indexPath))
    }
}

extension MoviesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentSize.height > scrollView.frame.height else { return }
        guard scrollView.contentSize.height <= scrollView.frame.height + scrollView.contentOffset.y && !didScrollToBottom else { return }
        didScrollToBottom = true
        viewModel?.fetchNextPageOfMovies()
    }
}
