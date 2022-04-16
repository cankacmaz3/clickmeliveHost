//
//  AppDelegate.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 9.04.2022.
//

import UIKit
import ClickmeliveHostCoreIOS

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        let listEventVC = ListEventsUIComposer.makeListEventsController()
        window?.rootViewController = listEventVC
        return true
    }

}

