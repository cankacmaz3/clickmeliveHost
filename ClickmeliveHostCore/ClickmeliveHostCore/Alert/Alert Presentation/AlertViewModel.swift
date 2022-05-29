//
//  AlertViewModel.swift
//  Clickmelive
//
//  Created by Can Kaçmaz on 23.05.2022.
//

import Foundation

public final class AlertViewModel {
    
    private let alert: Alert
    
    public init(alert: Alert) {
        self.alert = alert
    }
    
    public var message: String {
        return alert.message
    }
    
    public var actionButtonTitle: String {
        return alert.buttonTitle ?? Localized.Alert.defaultActionButtonTitle
    }
    
    public var actionCancelTitle: String {
        return alert.cancelButtonTitle ?? ""
    }
    
    public var isCancelButtonHidden: Bool {
        return alert.cancelButtonTitle == nil
    }
}

