//
//  ActivitiesViewController.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

protocol ActivitiesCoordinatorDelegate: class {
    
}

final class ActivitiesViewController: UIViewController, Storyboarded {
    weak var coordinator: ActivitiesCoordinatorDelegate?
}
