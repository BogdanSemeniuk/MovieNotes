//
//  UIAlertController+extension.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 05.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func make(withMessage message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }
}
