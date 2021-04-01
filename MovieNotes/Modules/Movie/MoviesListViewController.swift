//
//  MoviesListViewController.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

protocol MoviesListCoordinatorDelegate: class {
    
}

final class MoviesListViewController: UIViewController, Storyboarded {
    weak var coordinator: MoviesListCoordinatorDelegate?
    var viewModel: MovieListViewModel?
}
