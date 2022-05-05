//
//  UsePasswordUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class UsePasswordUIComposer {
    private init() {}
    
    static func makeUsePasswordController(openTransition: Transition) -> UsePasswordViewController {
        let router = UsePasswordRouter()
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let passwordAuthenticator = RemotePasswordAuthenticator(client: loadingClient, baseURL: AppEnvironment.baseURL)
        
        let usePasswordViewModel = UsePasswordViewModel(passwordAuthenticator: passwordAuthenticator)
        
        let usePasswordViewController = UsePasswordViewController(viewModel: usePasswordViewModel)
        router.viewController = usePasswordViewController
        router.openTransition = openTransition
        
        usePasswordViewController.onUseSmsTapped = {
            router.close()
        }
        
        usePasswordViewModel.onLogin = saveUserAndRouteToAppModule(router: router)
        
        usePasswordViewModel.onError = errorAlert(router: router)
        
        return usePasswordViewController
    }
    
    private static func saveUserAndRouteToAppModule(router: UsePasswordRouter) -> (Login) -> Void {
        { login in
            guard let token = login.token else { return }
            
            ClickMeUserDefaults.init().saveLoggedInUser(user: login.user)
            
            let saveUserToken = KeychainHelper.instance.setUserToken(token: token)
            if saveUserToken {
                router.openAppModule()
            }
        }
    }
    
    private static func errorAlert(router: UsePasswordRouter) -> (String) -> Void {
        { message in
            router.openAlertModule(message: message)
        }
    }
}
