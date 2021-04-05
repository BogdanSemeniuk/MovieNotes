//
//  MovieCell.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 05.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

final class MovieCell: UITableViewCell {
    var viewModel: MovieCellViewModelType? {
        didSet {
            configure()
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
}
