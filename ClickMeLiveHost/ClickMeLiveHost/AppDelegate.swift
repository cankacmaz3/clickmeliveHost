//
//  AppDelegate.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 9.04.2022.
//

import UIKit
import IQKeyboardManagerSwift
import ClickmeliveHostCoreIOS

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        setupIQKeyboard()
        
        print(KeychainHelper.instance.getUserToken() ?? "No token", "Token here")
        window?.rootViewController = AppModuleBuilder.module()
        return true
    }

}

extension AppDelegate {
    private func setupIQKeyboard() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemImage = UIImage(named: Image.dismiss_keyboard)
        IQKeyboardManager.shared.toolbarTintColor = Colors.primary
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
    }
}
