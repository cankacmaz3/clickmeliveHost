//
//  VideoContentRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import ClickmeliveHostCore

protocol ContentRoute {
    var contentTransition: Transition { get }
    func openContentModule(eventViewModel: EventViewModel?, contentType: CMLContentType)
}

extension ContentRoute where Self: RouterProtocol {
    func openContentModule(eventViewModel: EventViewModel? = nil, contentType: CMLContentType) {
        let module = ContentUIComposer.makeContentViewController(eventViewModel: eventViewModel, contentType: contentType)
        open(module, transition: contentTransition)
    }
}
