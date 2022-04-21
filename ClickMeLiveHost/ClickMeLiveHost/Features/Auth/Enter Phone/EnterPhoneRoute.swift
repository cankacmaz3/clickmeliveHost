//
//  EnterPhoneRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 21.04.2022.
//

protocol EnterPhoneRoute {
    var enterPhoneTransition: Transition { get }
    func openEnterPhoneModule()
}

extension EnterPhoneRoute where Self: RouterProtocol {
    func openEnterPhoneModule() {
        let module = EnterPhoneUIComposer.makeEnterPhoneController()
        open(module, transition: enterPhoneTransition)
    }
}

