//
//  AlertRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

protocol AlertRoute {
    func openAlertModule(messageTitle: String, buttonTitle: String, completion: @escaping () -> Void)
}

extension AlertRoute where Self: RouterProtocol {
    func openAlertModule(messageTitle: String, buttonTitle: String, completion: @escaping () -> Void = {}) {
        let module = AlertUIComposer.makeAlertController(messageTitle: messageTitle,
                                                         buttonTitle: buttonTitle,
                                                         completion: completion)
        let modelTransition = ModalTransition(isAnimated: false,
                                              modalTransitionStyle: .crossDissolve,
                                              modalPresentationStyle: .overFullScreen)
        open(module, transition: modelTransition)
    }
}
