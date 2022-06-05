//
//  LivestreamContentRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import ClickmeliveHostCore

protocol LivestreamContentRoute {
    var livestreamContentTransition: Transition { get }
    func openLivestreamContentModule()
}

extension LivestreamContentRoute where Self: RouterProtocol {
    func openLivestreamContentModule() {
        let module = LivestreamContentUIComposer.makeLivestreamContentViewController()
        open(module, transition: livestreamContentTransition)
    }
}
