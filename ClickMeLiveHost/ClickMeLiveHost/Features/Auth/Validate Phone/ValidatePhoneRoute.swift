//
//  ValidatePhoneRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

protocol ValidatePhoneRoute {
    var validatePhoneTransition: Transition { get }
    func openValidatePhoneModule()
}

extension ValidatePhoneRoute where Self: RouterProtocol {
    func openValidatePhoneModule() {
        let module = ValidatePhoneUIComposer.makeValidatePhoneController()
        open(module, transition: validatePhoneTransition)
    }
}


