//
//  VideoContentRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import ClickmeliveHostCore

protocol VideoContentRoute {
    var videoContentTransition: Transition { get }
    func openVideoContentModule(event: Event?)
}

extension VideoContentRoute where Self: RouterProtocol {
    func openVideoContentModule(event: Event? = nil) {
        let module = VideoContentUIComposer.makeVideoContentViewController(event: event)
        open(module, transition: videoContentTransition)
    }
}
