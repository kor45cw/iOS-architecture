//
//  AppDelegate.swift
//  MVP-Sample
//
//  Created by 손창우 on 02/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.rootViewController = UINavigationController(rootViewController: MainView.instance())
        window?.makeKeyAndVisible()
        return true
    }
}

