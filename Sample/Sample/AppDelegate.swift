//
//  AppDelegate.swift
//  Sample
//
//  Created by Son Chang Woo on 02/04/2019.
//  Copyright © 2019 kor45cw. All rights reserved.
//

import UIKit
import RIBs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)
        return true
    }
}

