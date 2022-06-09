//
//  ContentRouter.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class ContentRouter: Router<ContentViewController>, ContentRouter.Routes {
    typealias Routes = AlertRoute & ListProductRoute & VideoRoute & AppRoute
    var listProductTransition: Transition = PushTransition()
}


