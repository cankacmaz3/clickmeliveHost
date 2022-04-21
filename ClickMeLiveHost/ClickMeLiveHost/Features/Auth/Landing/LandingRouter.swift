//
//  LandingRouter.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class LandingRouter: Router<LandingViewController>, LandingRouter.Routes {
    typealias Routes = EnterPhoneRoute
    var enterPhoneTransition: Transition = PushTransition(isAnimated: true)
}
