//
//  RouterMock.swift
//  MovieNotesTests
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit
@testable import MovieNotes

final class RouterMock: Router {
    private(set) var onDismissed: (() -> Void)?
    private(set) var showWithOnDismissedWasCalled = false
    private(set) var hideWasCalled = false
    
    func show(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        self.onDismissed = onDismissed
        showWithOnDismissedWasCalled.toggle()
    }
    
    func hide(animated: Bool) {
        hideWasCalled = true
        onDismissed?()
    }
}
