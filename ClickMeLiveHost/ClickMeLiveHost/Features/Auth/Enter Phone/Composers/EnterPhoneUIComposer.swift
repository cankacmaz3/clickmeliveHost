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
        let viewModel = EnterPhoneViewModel()
        let enterPhoneViewController = EnterPhoneViewController(viewModel: viewModel)
        return enterPhoneViewController
    }
}


