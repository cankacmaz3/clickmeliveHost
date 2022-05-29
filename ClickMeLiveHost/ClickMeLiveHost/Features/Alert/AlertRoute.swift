//
//  AlertRoute.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

public protocol AlertRoute {
    func openAlertModule(message: String, buttonTitle: String?, cancelButtonTitle: String?, completion: @escaping () -> Void)
}

extension AlertRoute where Self: RouterProtocol {
    func openAlertModule(message: String, buttonTitle: String? = nil, cancelButtonTitle: String? = nil, completion: @escaping () -> Void = {}) {
        let module = AlertUIComposer.makeAlertViewController(message: message,
                                                             buttonTitle: buttonTitle,
                                                             cancelButtonTitle: cancelButtonTitle,
                                                             completion: completion)
        let modelTransition = ModalTransition(isAnimated: false,
                                              modalTransitionStyle: .crossDissolve,
                                              modalPresentationStyle: .overFullScreen)
        open(module, transition: modelTransition)
    }
}
