//
//  MovieDetailsViewController.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 19.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit
import Combine

protocol MovieDetailsCoordinatorDelegate: class {
}

final class MovieDetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: MovieDetailsCoordinatorDelegate?
    var movieDetails: MovieDetails!
    var viewModel: MovieDetailsViewModelType!
    
    private var bindings = Set<AnyCancellable?>()
    private lazy var loadingViewController = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
