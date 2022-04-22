//
//  AppRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//


import UIKit

protocol AppRoute {
    func openAppModule()
}

extension AppRoute where Self: RouterProtocol {
    func openAppModule() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = AppModuleBuilder.module()
    }
}

final class AppModuleBuilder {
    static func module() -> UIViewController {
        let userDefaults = ClickMeUserDefaults.init()
        
        if userDefaults.isItFirstLaunch {
            userDefaults.isItFirstLaunch = false
            KeychainHelper.instance.logout()
        }
        
        return KeychainHelper.instance.isUserLoggedIn() == true ?
            CMLNavigationController(rootViewController: ListEventsUIComposer.makeListEventsController()) :
            CMLNavigationController(rootViewController: LandingUIComposer.makeLandingController())
    
    }
}
