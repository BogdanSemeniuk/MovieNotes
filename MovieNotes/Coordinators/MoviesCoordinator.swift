//
//  MoviesCoordinator.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation

final class MoviesCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func show(animated: Bool, onDismissed: (() -> Void)?) {
        let vc = MoviesListViewController.instantiateFromStoryboard()
        vc.viewModel = MovieListViewModel(dataManager: DataManager(storage: UserDefaultsService(), networking: NetworkingService()))
        vc.coordinator = self
        router.show(vc, animated: animated, onDismissed: onDismissed)
    }
}

extension MoviesCoordinator: MoviesListCoordinatorDelegate {
    
}
