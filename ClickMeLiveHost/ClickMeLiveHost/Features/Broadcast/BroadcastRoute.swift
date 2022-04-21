//
//  BroadcastRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 17.04.2022.
//

protocol BroadcastRoute {
    var broadcastTransition: Transition { get }
    func openBroadcastModule()
}

extension BroadcastRoute where Self: RouterProtocol {
    func openBroadcastModule() {
        let module = BroadcasterUIComposer.makeBroadcastViewController()
        open(module, transition: broadcastTransition)
    }
}
