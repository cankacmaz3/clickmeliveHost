//
//  ListEventsRouter.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class ListEventsRouter: Router<ListEventsViewController>, ListEventsRouter.Routes {
    typealias Routes = BroadcastRoute
    var broadcastTransition: Transition = PushTransition(isAnimated: true)
}
