//
//  Storyboarded.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiateFromStoryboard() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiateFromStoryboard() -> Self {
        let viewControllerName = String(describing: self)
        let storyboardName = viewControllerName.replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewControllerName) as! Self
    }
}
