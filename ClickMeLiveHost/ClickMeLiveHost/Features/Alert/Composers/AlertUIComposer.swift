//
//  AlertUIComposer.swift
//  ClickMeLiveHost
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation
import ClickmeliveHostCoreIOS
import ClickmeliveHostCore

final class AlertUIComposer {
    private init() {}
    
    static func makeAlertController(message: String, buttonTitle: String?, completion: @escaping () -> Void) -> AlertViewController {
        let router = AlertRouter()
        
        let alert = Alert(message: message, buttonTitle: buttonTitle)
        let viewModel = AlertViewModel(alert: alert)
        
        let alertViewController = AlertViewController(viewModel: viewModel)
        router.openTransition = ModalTransition()
        router.viewController = alertViewController
        
        alertViewController.onActionTapped = completion
        alertViewController.onCloseTapped = {
            router.close()
        }
        return alertViewController
    }
}
