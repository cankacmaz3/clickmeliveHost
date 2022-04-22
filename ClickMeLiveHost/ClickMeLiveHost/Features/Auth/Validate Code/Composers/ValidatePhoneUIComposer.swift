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
        
        viewModel.onCodeValidated = { validateCode in
            guard let token = validateCode.token else { return }
            let saveUserToken = KeychainHelper.instance.setUserToken(token: token)
            if saveUserToken {
                router.openAppModule()
            }
        }
        
        viewModel.onError = { message in
            router.openAlertModule(message: message)
        }
        
        return validateCodeViewController
    }
}



