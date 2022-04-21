//
//  LandingUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation
import ClickmeliveHostCore
import ClickmeliveHostCoreIOS

final class LandingUIComposer {
    private init() {}
    
    static func makeLandingController() -> LandingViewController {
        let router = LandingRouter()
        let viewModel = LandingViewModel()
        let landingViewController = LandingViewController(landingViewModel: viewModel)
        
        router.viewController = landingViewController
        
        landingViewController.onLoginTapped = openEnterPhoneModule(router: router)
        
        return landingViewController
    }
    
    static func openEnterPhoneModule(router: LandingRouter) -> () -> Void {
        {
            router.openEnterPhoneModule()
        }
    }
}

