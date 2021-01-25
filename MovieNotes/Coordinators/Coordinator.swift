//
//  Coordinator.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var children: [Coordinator] { get set }
    var router: Router { get }
    
    func show(animated: Bool, onDismissed: (() -> Void)?)
    func hide(animated: Bool)
    func showChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)?)
}

extension Coordinator {
    func hide(animated: Bool) {
        router.hide(animated: animated)
    }
    
    func showChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)? = nil) {
        children.append(child)
        child.show(animated: animated, onDismissed: { [weak self, weak child] in
            guard let self = self, let child = child else { return }
            self.removeChild(child)
            onDismissed?()
        })
    }
    
    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where:  { $0 === child }) else { return }
        children.remove(at: index)
    }
}
