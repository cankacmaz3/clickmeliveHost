//
//  ValidatePhoneRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

protocol ValidateCodeRoute {
    var validateCodeTransition: Transition { get }
    func openValidateCodeModule(verificationCodeId: Int, phone: String)
}

extension ValidateCodeRoute where Self: RouterProtocol {
    func openValidateCodeModule(verificationCodeId: Int, phone: String) {
        let module = ValidateCodeUIComposer.makeValidateCodeController(verificationCodeId: verificationCodeId, phone: phone)
        open(module, transition: validateCodeTransition)
    }
}


