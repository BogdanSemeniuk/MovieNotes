//
//  AppDelegate.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 21.08.2020.
//  Copyright © 2020 Богдан Семенюк. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MoviesListViewController.instantiateFromStoryboard()
        return true
    }
}

