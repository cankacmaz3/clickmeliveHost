//
//  ProfileUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 30.04.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class ProfileUIComposer {
    private init() {}
    
    static func makeProfileViewController() -> ProfileViewController {
        return ProfileViewController()
    }
}
