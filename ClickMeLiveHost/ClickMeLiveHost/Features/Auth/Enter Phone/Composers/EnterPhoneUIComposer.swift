//
//  EnterPhoneUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class EnterPhoneUIComposer {
    private init() {}
    
    static func makeEnterPhoneController() -> EnterPhoneViewController {
        let router = EnterPhoneRouter()
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authCodeCreator = RemoteAuthCodeCreator(client: loadingClient, baseURL: AppEnvironment.baseURL)
        let viewModel = EnterPhoneViewModel(authCodeCreator: authCodeCreator)
        
        let enterPhoneViewController = EnterPhoneViewController(viewModel: viewModel)
        router.viewController = enterPhoneViewController
        
        viewModel.onCodeCreated = { code in
            router.openValidatePhoneModule()
            print(code.id, code.phone, "created")
        }
        
        viewModel.onError = { (errorAlert) in
            let (errorMessage, buttonTitle) = errorAlert
            router.openAlertModule(messageTitle: errorMessage, buttonTitle: buttonTitle)
        }
        
        return enterPhoneViewController
    }
}


