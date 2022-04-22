//
//  EnterPhoneRouter.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class EnterPhoneRouter: Router<EnterPhoneViewController>, EnterPhoneRouter.Routes {
    typealias Routes = AlertRoute & ValidatePhoneRoute
    var validatePhoneTransition: Transition = PushTransition(isAnimated: true)
}
