//
//  Router.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

protocol Router: class {
    func show(_ viewController: UIViewController, animated: Bool)
    func show(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?)
    func hide(animated: Bool)
}

extension Router {
    func show(_ viewController: UIViewController, animated: Bool) {
        show(viewController, animated: animated, onDismissed: nil)
    }
}
