//
//  CoordinatorMock.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit
@testable import MovieNotes

final class CoordinatorMock: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    private(set) var showWasCalled = false
    
    init(router: Router) {
        self.router = router
    }
    
    func show(animated: Bool, onDismissed: (() -> Void)?) {
        let vc = UIViewController()
        router.show(vc, animated: animated, onDismissed: onDismissed)
        showWasCalled = true
    }
}
