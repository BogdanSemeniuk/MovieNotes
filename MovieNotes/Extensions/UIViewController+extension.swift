//
//  UIViewController+extension.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 05.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, container: UIView) {
        child.view.frame = container.bounds
        addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
