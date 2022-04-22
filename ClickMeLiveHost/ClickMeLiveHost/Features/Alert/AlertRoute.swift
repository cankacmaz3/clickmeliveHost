//
//  AlertRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

protocol AlertRoute {
    func openAlertModule(message: String, buttonTitle: String?, completion: @escaping () -> Void)
}

extension AlertRoute where Self: RouterProtocol {
    func openAlertModule(message: String, buttonTitle: String? = nil, completion: @escaping () -> Void = {}) {
        let module = AlertUIComposer.makeAlertController(message: message,
                                                         buttonTitle: buttonTitle,
                                                         completion: completion)
        let modelTransition = ModalTransition(isAnimated: false,
                                              modalTransitionStyle: .crossDissolve,
                                              modalPresentationStyle: .overFullScreen)
        open(module, transition: modelTransition)
    }
}
