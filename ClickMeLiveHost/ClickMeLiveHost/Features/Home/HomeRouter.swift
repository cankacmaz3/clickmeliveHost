//
//  HomeRouter.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 29.05.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class HomeRouter: Router<HomeViewController>, HomeRouter.Routes {
    typealias Routes = BroadcastRoute & AlertRoute & VideoRoute & VideoContentRoute
    var broadcastTransition: Transition = PushTransition(isAnimated: true, hidesBottomBarWhenPushed: true)
    var videoContentTransition: Transition = PushTransition(isAnimated: true, hidesBottomBarWhenPushed: true)
}
