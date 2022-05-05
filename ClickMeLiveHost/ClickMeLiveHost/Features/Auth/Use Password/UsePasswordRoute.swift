//
//  UsePasswordRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 5.05.2022.
//

import Foundation

protocol UsePasswordRoute {
    var usePasswordTransition: Transition { get }
    func openUsePasswordModule()
}

extension UsePasswordRoute where Self: RouterProtocol {
    func openUsePasswordModule() {
        let module = UsePasswordUIComposer.makeUsePasswordController(openTransition: usePasswordTransition)
        open(module, transition: usePasswordTransition)
    }
}
