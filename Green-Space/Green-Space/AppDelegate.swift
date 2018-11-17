//
//  AppDelegate.swift
//  Green-Space
//
//  Created by Galushka on 11/17/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate var startScreen: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        startScreen = StartViewController.instantiateFromStoryboard()
        
        window = UIWindow.init(frame:UIScreen.main.bounds);
        window?.rootViewController = startScreen
        window?.makeKeyAndVisible()
        
        return true
    }
}

