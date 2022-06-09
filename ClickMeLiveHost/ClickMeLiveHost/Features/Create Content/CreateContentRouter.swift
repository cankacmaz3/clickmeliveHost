//
//  CreateContentRouter.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 3.06.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class CreateContentRouter: Router<CreateContentViewController>, CreateContentRouter.Routes {
    typealias Routes = VideoRoute & ContentRoute
    var contentTransition: Transition = PushTransition()
    var livestreamContentTransition: Transition = PushTransition()
}

