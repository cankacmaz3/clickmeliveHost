//
//  ValidateCodeUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class ValidateCodeUIComposer {
    private init() {}
    
    static func makeValidateCodeController(verificationCodeId: Int, phone: String) -> ValidateCodeViewController {
        let router = ValidateCodeRouter()
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authCodeValidator = RemoteAuthCodeValidator(client: loadingClient, baseURL: AppEnvironment.baseURL)
        
        let viewModel = ValidateCodeViewModel(phone: phone,
                                              verificationCodeId: verificationCodeId,
                                              authCodeValidator: authCodeValidator)
        
        let validateCodeViewController = ValidateCodeViewController(viewModel: viewModel)
        router.viewController = validateCodeViewController
        
        viewModel.onCodeValidated = saveUserAndRouteToAppModule(router: router)
        
        viewModel.onError = errorAlert(router: router)
        
        return validateCodeViewController
    }
    
    private static func saveUserAndRouteToAppModule(router: ValidateCodeRouter) -> (ValidateCode) -> Void {
        { validateCode in
            guard let token = validateCode.token else { return }
            
            ClickMeUserDefaults.init().saveLoggedInUser(user: validateCode.user)
            
            let saveUserToken = KeychainHelper.instance.setUserToken(token: token)
            if saveUserToken {
                router.openAppModule()
            }
        }
    }
    
    private static func errorAlert(router: ValidateCodeRouter) -> (String) -> Void {
        { message in
            router.openAlertModule(message: message)
        }
    }
}



