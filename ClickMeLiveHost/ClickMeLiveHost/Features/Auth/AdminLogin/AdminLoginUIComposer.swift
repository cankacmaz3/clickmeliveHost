//
//  AdminLoginUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 20.05.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class AdminLoginUIComposer {
    private init() {}
    
    static func makeAdminLoginController(openTransition: Transition) -> AdminLoginViewController {
        let router = AdminLoginRouter()
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let adminAuthenticator = RemoteAdminAuthenticator(client: loadingClient, baseURL: AppEnvironment.baseURL)
        
        let adminViewModel = AdminViewModel(adminAuthenticator: adminAuthenticator)
        
        let adminLoginViewController = AdminLoginViewController(viewModel: adminViewModel)
        router.viewController = adminLoginViewController
        router.openTransition = openTransition
        
        adminLoginViewController.onUseSmsTapped = {
            router.close()
        }
        
        adminViewModel.onLogin = saveUserAndRouteToAppModule(router: router)
        
        adminViewModel.onError = errorAlert(router: router)
        
        return adminLoginViewController
    }
    
    private static func saveUserAndRouteToAppModule(router: AdminLoginRouter) -> (Login) -> Void {
        { login in
            guard let token = login.token else { return }
            
            ClickMeUserDefaults.init().saveLoggedInUser(user: login.user)
            
            let saveUserToken = KeychainHelper.instance.setUserToken(token: token)
            if saveUserToken {
                router.openAppModule()
            }
        }
    }
    
    private static func errorAlert(router: AdminLoginRouter) -> (String) -> Void {
        { message in
            router.openAlertModule(message: message)
        }
    }
}
