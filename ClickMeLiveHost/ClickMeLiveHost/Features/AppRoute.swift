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
    
    private enum Constants {
        static let homeTabImage: String = "icon_home"
        static let profileTabImage: String = "icon_profile"
    }
   
    static func module() -> UIViewController {
        let userDefaults = ClickMeUserDefaults.init()
        
        if userDefaults.isItFirstLaunch {
            userDefaults.isItFirstLaunch = false
            KeychainHelper.instance.logout()
        }
        
        return KeychainHelper.instance.isUserLoggedIn() == true ?
            makeRootViewController():
            CMLNavigationController(rootViewController: LandingUIComposer.makeLandingController())
    
    }
    
    private static func makeRootViewController() -> UIViewController {
        let tabBarController = CMLTabBarController()
        
        tabBarController.viewControllers = [listEventsViewController(), profileViewController()]
        return tabBarController
    }
    
    private static func listEventsViewController() -> UIViewController {
        let view = CMLNavigationController(rootViewController: ListEventsUIComposer.makeListEventsController())
        view.tabBarItem.image = UIImage(named: Constants.homeTabImage)
        return view
    }
    
    private static func profileViewController() -> UIViewController {
        let view = CMLNavigationController(rootViewController: ProfileUIComposer.makeProfileViewController())
        view.tabBarItem.image = UIImage(named: Constants.profileTabImage)
        return view
    }
}
