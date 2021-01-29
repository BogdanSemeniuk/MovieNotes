//
//  MainCoordinator.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 25.01.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func show(animated: Bool, onDismissed: (() -> Void)?) {
        let tabBarController = UITabBarController()
        
        let moviesNavigationController = UINavigationController()
        moviesNavigationController.isNavigationBarHidden = true
        moviesNavigationController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movieBlack"), tag: 0)

        let activitiesNavigationController = UINavigationController()
        activitiesNavigationController.isNavigationBarHidden = true
        activitiesNavigationController.tabBarItem = UITabBarItem(title: "Activities", image: UIImage(named: "accountCircle"), tag: 1)
        
        tabBarController.viewControllers = [moviesNavigationController, activitiesNavigationController]
        
        router.show(tabBarController, animated: true)
        
        let moviesRouter = MoviesRouter(navigationController: moviesNavigationController)
        let moviesCoordinator = MoviesCoordinator(router: moviesRouter)
        
        let activitiesRouter = ActivitiesRouter(navigationController: activitiesNavigationController)
        let activitiesCoordinator = ActivitiesCoordinator(router: activitiesRouter)
        
        showChild(moviesCoordinator, animated: false)
        showChild(activitiesCoordinator, animated: false)
    }
}
