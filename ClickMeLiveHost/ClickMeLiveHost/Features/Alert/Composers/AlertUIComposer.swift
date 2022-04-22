//
//  AlertUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import ClickmeliveHostCoreIOS

final class AlertUIComposer {
    private init() {}
    
    static func makeAlertController(messageTitle: String, buttonTitle: String, completion: @escaping () -> Void) -> AlertViewController {
        let router = AlertRouter()
        
        let alertViewController = AlertViewController(messageTitle: messageTitle, buttonTitle: buttonTitle)
        router.openTransition = ModalTransition()
        router.viewController = alertViewController
        
        alertViewController.onActionTapped = completion
        alertViewController.onCloseTapped = {
            router.close()
        }
        return alertViewController
    }
}
