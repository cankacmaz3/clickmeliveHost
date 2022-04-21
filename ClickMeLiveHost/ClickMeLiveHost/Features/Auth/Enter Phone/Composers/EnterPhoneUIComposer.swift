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
        let client = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let loadingClient = LoadingViewHTTPClientDecorator(decoratee: client, loadingView: LoadingView.instance)
        
        let authCodeCreator = RemoteAuthCodeCreator(client: loadingClient, baseURL: AppEnvironment.baseURL)
        let viewModel = EnterPhoneViewModel(authCodeCreator: authCodeCreator)
        
        viewModel.onCodeCreated = { code in
            print(code.id, code.phone, "created")
        }
        
        let enterPhoneViewController = EnterPhoneViewController(viewModel: viewModel)
        return enterPhoneViewController
    }
}


