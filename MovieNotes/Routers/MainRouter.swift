//
//  MainRouter.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

final class MainRouter: Router {
    public let window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    func show(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        
    }
    
    func hide(animated: Bool) {
        
    }
}
