//
//  SceneDelegate.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 21.08.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var mainCoordinator: MainCoordinator!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            let mainRouter = MainRouter(window: window!)
            mainCoordinator = MainCoordinator(router: mainRouter)
            mainCoordinator.show(animated: false, onDismissed: nil)
        }
    }
}

