//
//  ProfileUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 30.04.2022.
//

import Foundation
import ClickmeliveHostCoreIOS
import ClickmeliveHostCore

final class ProfileUIComposer {
    private init() {}
    
    static func makeProfileViewController() -> ProfileViewController {
        let router = ProfileRouter()
        let viewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: viewModel)
        
        if let user = ClickMeUserDefaults.init().getLoggedInUser() {
            profileViewController.navigationItem.title = user.username
        }
        
        profileViewController.onLogoutTapped = {
            KeychainHelper.init().logout()
            router.openAppModule()
        }
        
        return profileViewController
    }
}
