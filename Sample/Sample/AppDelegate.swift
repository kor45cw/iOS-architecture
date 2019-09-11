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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter.launchRouter
        self.shortcutHandler = launchRouter.shortcutHandler
        self.launchRouter?.launchFromWindow(window)
        return true
    }
    
    /// - Tag: PerformAction
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        shortcutHandler?.application(performActionFor: shortcutItem)
    }
    
    /// - Tag: WillResignActive
    func applicationWillResignActive(_ application: UIApplication) {
        application.shortcutItems = SampleShortcutItem.allCases.map { item -> UIApplicationShortcutItem in
            return UIApplicationShortcutItem(type: item.type,
                                             localizedTitle: item.localizedTitle,
                                             localizedSubtitle: nil,
                                             icon: item.icon,
                                             userInfo: nil)
        }
    }
    
    
    
    // MARK: - Private

    private var launchRouter: LaunchRouting?
    private var shortcutHandler: ShortcutHandler?
}

protocol ShortcutHandler: class {
    func application(performActionFor shortcutItem: UIApplicationShortcutItem)
}
