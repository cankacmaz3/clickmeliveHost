//
//  VideoContentRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.06.2022.
//

import ClickmeliveHostCore

protocol VideoContentRoute {
    var videoContentTransition: Transition { get }
    func openVideoContentModule()
}

extension VideoContentRoute where Self: RouterProtocol {
    func openVideoContentModule() {
        let module = VideoContentUIComposer.makeVideoContentViewController()
        open(module, transition: videoContentTransition)
    }
}
