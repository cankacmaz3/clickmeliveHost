//
//  BroadcastRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

import ClickmeliveHostCore

protocol BroadcastRoute {
    var broadcastTransition: Transition { get }
    func openBroadcastModule(with event: Event)
}

extension BroadcastRoute where Self: RouterProtocol {
    func openBroadcastModule(with event: Event) {
        let module = BroadcasterUIComposer.makeBroadcastViewController(event: event, openTransition: broadcastTransition)
        open(module, transition: broadcastTransition)
    }
}
