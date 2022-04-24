//
//  BroadcastRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

protocol BroadcastRoute {
    var broadcastTransition: Transition { get }
    func openBroadcastModule(with eventId: Int)
}

extension BroadcastRoute where Self: RouterProtocol {
    func openBroadcastModule(with eventId: Int) {
        let module = BroadcasterUIComposer.makeBroadcastViewController(eventId: eventId, openTransition: broadcastTransition)
        open(module, transition: broadcastTransition)
    }
}
